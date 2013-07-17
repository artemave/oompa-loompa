require 'key_struct'

class Link < KeyStruct[:score, :title, :url, :source, :comments_url]
end
