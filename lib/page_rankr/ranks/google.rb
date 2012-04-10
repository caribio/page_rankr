require File.expand_path('../../rank', __FILE__)
require File.expand_path('../google/checksum', __FILE__)

module PageRankr
  class Ranks
    class Google
      include Rank

      def initialize(site)
        @site = PageRankr::Site(site)
        @checksum = Checksum.generate("info:#{@site.original_url}")
        
        super(site)
      end

      def supported_components
        [:subdomain, :path]
      end

      def url
        "http://toolbarqueries.google.com/tbr"
      end

      def params
        orig_url = @site.original_url
        # p "Orig_url #{orig_url}"
        {:client => "navclient-auto", :ch => @checksum, :features => "Rank", :q => "info:#{orig_url}"}
      end

      def regex
        /Rank_\d+:\d+:(\d+)/
      end
    end
  end
end
