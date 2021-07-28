module Parser
  class ToolSpec
    def self.update(master_spec, keys)
      keys.total_pages.times do
        keys = keys.next_page unless keys.first_page?
        keys.collection.each do |key|
          key_name = key.raw_data.dig('key_name', 'other')
          path = key_name.split('_').map(&:to_s)[1..-1]
          value = key.raw_data['translations'].last['translation']

          deep_set(master_spec, path, value)
        end
      end

      master_spec
    end

    def self.deep_set(master_spec, path, value)
      *path, final_key = path
      to_set = path.empty? ? master_spec : master_spec.dig(*path)

      return unless to_set
      to_set[final_key] = value
    end
  end
end
