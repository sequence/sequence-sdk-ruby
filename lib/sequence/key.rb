# frozen_string_literal: true

require_relative './client_module'
require_relative './session'
require_relative './query'
require_relative './response_object'

module Sequence
  # Keys are used to sign transactions.
  class Key < ResponseObject
    # @!attribute [r] id
    #   Unique identifier of the key, based on the public key material itself.
    # @return [String]
    attrib :id

    class ClientModule < Sequence::ClientModule
      # Creates a key.
      # @param [Hash] opts
      #   Options hash
      # @option opts [String] id
      #   Unique identifier. Auto-generated if not specified.
      # @return [Key]
      def create(opts = {})
        validate_inclusion_of!(opts, :id)
        Key.new(client.session.request('create-key', opts))
      end

      # Lists all keys.
      # Executes a query, returning an enumerable over individual keys.
      # @return [Query]
      def list
        Query.new(client)
      end
    end

    class Query < Sequence::Query
      def fetch(query)
        client.session.request('list-keys', query)
      end

      def translate(obj)
        Key.new(obj)
      end
    end
  end
end
