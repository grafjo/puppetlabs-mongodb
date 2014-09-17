require 'puppet'
require 'puppet/type/mongodb_user'
describe Puppet::Type.type(:mongodb_user) do

  before :each do
    @user = Puppet::Type.type(:mongodb_user).new(
              :name => 'test',
              :database => 'testdb',
              :password => 'pass')
  end

  it 'should accept a user name' do
    @user[:name].should == 'test'
  end

  it 'should accept a database name' do
    @user[:database].should == 'testdb'
  end

  it 'should accept a tries parameter' do
    @user[:tries] = 5
    @user[:tries].should == 5
  end

  it 'should accept a password' do
    @user[:password] = 'foo'
    @user[:password].should == 'foo'
  end

  it 'should use default role' do
    @user[:roles].should == ['dbAdmin']
  end

  it 'should accept a roles array' do
    @user[:roles] = ['role1', 'role2']
    @user[:roles].should == ['role1', 'role2']
  end

  it 'should require a name' do
    expect {
      Puppet::Type.type(:mongodb_user).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should require a database' do
    expect {
      Puppet::Type.type(:mongodb_user).new({:name => 'test', :password => 'pass'})
    }.to raise_error(Puppet::Error, 'Parameter \'database\' must be set')
  end

  it 'should require a password' do
    expect {
      Puppet::Type.type(:mongodb_user).new({:name => 'test', :database => 'testdb'})
    }.to raise_error(Puppet::Error, 'Property \'password\' must be set.')
  end

  it 'should sort roles' do
    # Reinitialize type with explicit unsorted roles.
    @user = Puppet::Type.type(:mongodb_user).new(
              :name => 'test',
              :database => 'testdb',
              :password => 'pass',
              :roles => ['b', 'a'])
    @user[:roles].should == ['a', 'b']
  end

end
