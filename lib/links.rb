class Links
  def self.fetch
    crawlers.inject([]) do |acc, crawler|
      acc += crawler.fetch
    end.select do |link|
      link.score.present?
    end
  end

  private

  def self.crawlers
    @@crawlers ||= begin
                     Dir[File.expand_path '../crawlers/*.rb', __FILE__].map do |file|
                       require file
                       filename_to_classname(file).constantize
                     end
                   end
  end

  def self.filename_to_classname file
    File.basename(file).sub(/.rb$/, '').split('_').map(&:capitalize).join
  end
end
