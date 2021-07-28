module Parser
  class TranslationKey
    def self.fetch(tool_spec)
      keys= []
      tool_id = tool_spec[:id]
      tool_spec = tool_spec.except(:version, :tool_version, :id, :isMedicalDevice)
      translatable_nodes = flatten_hash(tool_spec)
      
      translatable_nodes.each do |key, value| 
        keys << key_object("#{tool_id}_#{key}", value, tool_spec[:language])
      end
      
      keys
    end

    def self.flatten_hash(hash)
      hash.each_with_object({}) do |(k, v), h|
        if v.is_a? Hash
          flatten_hash(v).map do |h_k, h_v|
            h["#{k}_#{h_k}".to_sym] = h_v if translatable_node?(h_v)
          end
        else 
          h[k] = v if translatable_node?(v)
        end
      end
    end

    def self.translatable_node?(value)
      value.is_a? String
    end

    def self.key_object(key, value, language)
      {
        key_name: key.to_s,
        platforms: Constant::LOKALISE_PLATFORMS,
        translations: [
            {
                language_iso: language.downcase,
                translation: value
            }
        ]
      }
    end
  end
end
