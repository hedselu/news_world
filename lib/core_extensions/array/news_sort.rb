module CoreExtensions
  module Array
    module NewsSort
      def sort
        sort_by { |news| news.up_votes + down_votes }
      end
    end
  end
end
