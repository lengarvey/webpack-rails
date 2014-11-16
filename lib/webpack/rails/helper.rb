require 'action_view'

module Webpack
  module Rails
    module Helper
      include ActionView::Helpers::AssetUrlHelper
      include ActionView::Helpers::AssetTagHelper

      def stylesheet_link_tag(*sources)
        options = sources.extract_options!.stringify_keys

        if options['debug'] != false
          sources.map do |source|
            super("/assets/#{source}", options)
          end.flatten.uniq.join('\n').html_safe
        else
          super(*sources)
        end
      end

      def javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys

        if options['debug'] != false
          sources.map do |source|
            super("/assets/#{source}", options)
          end.flatten.uniq.join('\n').html_safe
        else
          super(*sources)
        end
      end
    end
  end
end
