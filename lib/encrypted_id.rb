require 'openssl'
require 'active_record'
require 'encrypted_id/version'

module EncryptedId

  CIPHER_NAME = 'aes-256-cbc'
  CIPHER_IV = ['1e5673b2572af26a8364a50af84c7d2a'].pack('H*')

  def encrypted_id(options = {})
    extend ClassMethods
    include InstanceMethods
    cattr_accessor :encrypted_id_key
    self.encrypted_id_key = Digest::SHA256.digest(options[:key] || encrypted_id_default_key)
    self.define_singleton_method(:find_single, lambda { puts "foo" })
  end

  def self.decrypt(key, id)
    c = OpenSSL::Cipher::Cipher.new(CIPHER_NAME).decrypt
    c.iv = CIPHER_IV
    c.key = key
    c.update([id].pack('H*')) + c.final
  end

  def self.encrypt(key, id)
    c = OpenSSL::Cipher::Cipher.new(CIPHER_NAME).encrypt
    c.iv = CIPHER_IV
    c.key = key
    (c.update("#{id}") + c.final).unpack('H*')[0]
  end

  module ClassMethods
    def find(*args)
      scope = args.slice!(0)
      options = args.slice!(0) || {}
      if !(scope.is_a? Symbol) && has_encrypted_id? && !options[:no_encrypted_id]
        begin
          scope = EncryptedId.decrypt(encrypted_id_key, "#{scope}")
        rescue OpenSSL::Cipher::CipherError
          raise ActiveRecord::RecordNotFound.new("Could not decrypt ID #{args[0]}")
        end
      end
      options.delete(:no_encrypted_id)
      super(scope)
    end

    def has_encrypted_id?
      true
    end

    def encrypted_id_default_key
      name
    end
  end

  module InstanceMethods
    def to_param
      EncryptedId.encrypt(self.class.encrypted_id_key, self.id)
    end

    def to_key
      key = self.id or nil
      if key
        key = [EncryptedId.encrypt(self.class.encrypted_id_key, self.id)]
      end
      key
    end

    def reload(options = nil)
      options = (options || {}).merge(:no_encrypted_id => true)
      super(options)
    end
  end
end

ActiveRecord::Base.extend EncryptedId
