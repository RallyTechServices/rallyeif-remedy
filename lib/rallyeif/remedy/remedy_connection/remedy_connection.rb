# Copyright 2001-2015 Rally Software Development Corp. All Rights Reserved.

require 'rallyeif-wrk'

RecoverableException   = RallyEIF::WRK::RecoverableException if not defined?(RecoverableException)
UnrecoverableException = RallyEIF::WRK::UnrecoverableException
RallyLogger            = RallyEIF::WRK::RallyLogger
XMLUtils               = RallyEIF::WRK::XMLUtils

module RallyEIF
  module WRK
                              
    class RemedyConnection < Connection

      attr_reader   :remedy, :url
      
      def initialize(config=nil)
        super()
        read_config(config) if !config.nil?
      end
      
      def read_config(config)
        super(config)
        @url     = XMLUtils.get_element_value(config, self.conn_class_name.to_s, "Url")
      end
      
      def name()
        return "Remedy"
      end
      
      def version()
        return RallyEIF::Remedy::Version
      end

      def self.version_message()
        version_info = "#{RallyEIF::Remedy::Version}-#{RallyEIF::Remedy::Version.detail}"
        return "RemedyConnection version #{version_info}"
      end
      
      def get_backend_version()
        return "%s %s" % [name, version]
      end
#---------------------#
      def connect()    
        RallyLogger.debug(self, "********************************************************")
        RallyLogger.debug(self, "Connecting to Remedy:")
        RallyLogger.debug(self, "  Url               : #{@url}")
        RallyLogger.debug(self, "  Username          : #{@user}")
        RallyLogger.debug(self, "  Connector Name    : #{name}")
        RallyLogger.debug(self, "  Connector Version : #{version}")
        RallyLogger.debug(self, "  Artifact Type     : #{artifact_type}")
        RallyLogger.debug(self, "*******************************************************")   
        
        #
        # Set up a connection packet
        #
        @remedy          =  nil # TODO
        

        return @remedy
      end
      
#---------------------#
      def create_internal(int_work_item)
        # TODO 
        new_item = int_work_item
        
        return new_item
      end
#---------------------#
      def delete(item)
        # TODO
        return nil
      end
#---------------------#
      def disconnect()
        RallyLogger.info(self,"Would disconnect at this point if we needed to")
      end
#---------------------#
      def field_exists? (field_name)
        # TODO
        return true
      end

#---------------------#
      # find_by_external_id is forced from inheritance
      def find_by_external_id(external_id)
        # TODO
        return nil
      end
#---------------------#
      def find_new()
        RallyLogger.info(self, "Find new Remedy '#{@artifact_type}' objects")
        returned_artifacts = []
        
        # TODO

        RallyLogger.info(self, "Found '#{matching_artifacts.length}' new '#{@artifact_type}' objects in '#{name()}'")
        
        return matching_artifacts
      end
   
#---------------------#
      def find_updates(reference_time)
        RallyLogger.info(self, "Find updated Remedy '#{@artifact_type}' objects since '#{reference_time}'")
        artifact_array = []
          
        RallyLogger.info(self, "Found '#{artifact_array.length}' updated '#{@artifact_type}' objects in '#{name()}'")
        return artifact_array
      end
#---------------------#
      # This method will hide the actual call of how to get the id field's value
      def get_id_value(artifact)
        return get_value(artifact,'id')
      end
#---------------------#
      def get_object_link(artifact)
        # TODO
        linktext = artifact[@id_field] || 'link'
        it = "<a href='https://#{@url}/#{artifact['id']}'>#{linktext}</a>"
        return it
      end
#---------------------#
      def get_value(artifact,field_name)
        return artifact["#{field_name.downcase}"]
      end
#---------------------#
      def pre_create(int_work_item)
        return int_work_item
      end
#---------------------#
      def update_internal(artifact, new_fields)
        # TODO
        updated_item = artifact
        return updated_item
      end
#---------------------#
      def update_external_id_fields(artifact, external_id, end_user_id, item_link)
        # TODO
        updated_item = artifact
        return updated_item
      end
#---------------------#
      def validate
        status_of_all_fields = true  # Assume all fields will pass
        
        #sys_name = 'custom_' + @external_id_field.to_s.downcase
        if !field_exists?(@external_id_field)
          status_of_all_fields = false
          RallyLogger.error(self, "<ExternalIDField> '#{@external_id_field}' does not exist in '#{name()}'")
        end

        if @id_field
          if !field_exists?(@id_field)
            status_of_all_fields = false
            RallyLogger.error(self, "<IDField> '#{@id_field}' does not exist in '#{name()}'")
          end
        end

        if @external_end_user_id_field
          if !field_exists?(@external_end_user_id_field)
            status_of_all_fields = false
            RallyLogger.error(self, "<ExternalEndUserIDField> '#{@external_end_user_id_field}' does not exist in '#{name()}'")
          end
        end
        
        return status_of_all_fields
      end
#---------------------#
    end
  end
end