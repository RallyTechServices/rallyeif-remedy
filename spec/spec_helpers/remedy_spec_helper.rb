# Copyright 2001-2015 Rally Software Development Corp. All Rights Reserved.
require File.dirname(__FILE__) + '/spec_helper'
if !File.exist?(File.dirname(__FILE__) + '/test_configuration_helper.rb')
  puts
  puts " You must create a file with your test values at #{File.dirname(__FILE__)}/test_configuration_helper.rb"
  exit 1
end
require File.dirname(__FILE__) + '/test_configuration_helper'
require 'rallyeif-wrk'
require File.dirname(__FILE__) + '/../../lib/rallyeif-remedy'
#

include YetiTestUtils

module RemedySpecHelper

  RemedyConnection        = RallyEIF::WRK::RemedyConnection     if not defined?(RemedyConnection)
  RecoverableException    = RallyEIF::WRK::RecoverableException   if not defined?(RecoverableException)
  UnrecoverableException  = RallyEIF::WRK::UnrecoverableException if not defined?(UnrecoverableException)
  YetiSelector            = RallyEIF::WRK::YetiSelector           if not defined?(YetiSelector)
  FieldMap                = RallyEIF::WRK::FieldMap               if not defined?(FieldMap)
  Connector               = RallyEIF::WRK::Connector              if not defined?(Connector)
  
  REMEDY_BASIC_CONFIG = "
    <config>
      <RemedyConnection>
        <Url>#{TestConfig::REMEDY_URL}</Url>
        <User>#{TestConfig::REMEDY_USER}</User>
        <Password>#{TestConfig::REMEDY_PASSWORD}</Password>
        <ExternalIDField>#{TestConfig::REMEDY_EXTERNAL_ID_FIELD}</ExternalIDField>
        <ArtifactType>#{TestConfig::REMEDY_ARTIFACT_TYPE}</ArtifactType>
      </RemedyConnection>
    </config>"

      
  def remedy_connect(config_file)
    root = YetiTestUtils::load_xml(config_file).root
    connection = RemedyConnection.new(root)
    connection.connect()
    return connection
  end
  
  def create_remedy_artifact(connection, extra_fields = nil)
    # Generate a title like "Time-2015-01-06_12:04:12-965143"
    title = 'Time-' + Time.now.strftime("%Y-%m-%d_%H:%M:%S") + '-' + Time.now.usec.to_s
    current_artifact = connection.artifact_type.to_s.downcase

    fields = {  'title'         => "Auto Test Case - #{title}"  }
    fields.merge!(extra_fields) if !extra_fields.nil?
    item = connection.create(fields)
    return [item, item['title']]

  end
  
end

class RemedyItem
  attr_accessor :Name
  
  def initialize(name=nil)
    if name.nil?
      @Name = "fred"
    else 
      @Name = name
    end
  end
  
end