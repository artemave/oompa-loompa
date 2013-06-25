class Links
  def self.fetch
    sources.inject([]) do |acc, source|
      acc += source.fetch
    end
  end

  private

  def self.sources
    @@sources ||= begin
                    Dir[File.expand_path '../link_sources/*.rb', __FILE__].map do |file|
                      require file
                      filename_to_classname(file).constantize
                    end
                  end
  end

  def self.filename_to_classname file
    File.basename(file).sub(/.rb$/, '').split('_').map(&:capitalize).join
  end
end
