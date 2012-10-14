require 'openssl'

module EncryptedId

  CIPHER_NAME = 'aes-256-cbc'
  CIPHER_IV = ['1e5673b2572af26a8364a50af84c7d2a'].pack('H*')

  def encrypted_id(options = {})
    extend ClassMethods
    include InstanceMethods
    cattr_accessor :encrypted_id_key
    self.encrypted_id_key = Digest::SHA256.digest(options[:key] || encrypted_id_default_key)
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
      if has_encrypted_id?
        begin
          args[0] = EncryptedId.decrypt(encrypted_id_key, "#{args[0]}")
        rescue OpenSSL::Cipher::CipherError
          raise ActiveRecord::RecordNotFound.new("Could not decrypt ID #{args[0]}")
        end
      end
      super(*args)
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
  end
end

ActiveRecord::Base.extend EncryptedId
