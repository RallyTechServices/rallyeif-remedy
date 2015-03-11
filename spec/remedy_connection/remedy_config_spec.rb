require File.dirname(__FILE__) + '/../spec_helpers/spec_helper'
require File.dirname(__FILE__) + '/../spec_helpers/remedy_spec_helper'

include RemedySpecHelper
include YetiTestUtils

describe "Given configuration in the Remedy section" do
  before(:all) do
    # 
  end

  it "should successfully load basic config settings " do
    connection = remedy_connect(RemedySpecHelper::REMEDY_BASIC_CONFIG)
    expect(connection.artifact_type).to eq(TestConfig::REMEDY_ARTIFACT_TYPE.downcase.to_sym)
    expect(connection.url).to eq(TestConfig::REMEDY_URL)
    expect(connection.user).to eq(TestConfig::REMEDY_USER)
    expect(connection.password).to eq(TestConfig::REMEDY_PASSWORD)
    expect(connection.external_id_field).to eq(TestConfig::REMEDY_EXTERNAL_ID_FIELD.downcase.to_sym)

  end
  
end