module Sunspot
  module Solr
    module Java
      def self.installed?
        #{}`java -version &> /dev/null`
        #$?.success?
        !ENV["JAVA_HOME"].blank?
      end
    end
  end
end