class ProfileRepresenter
  def initialize(profile)
    @profile = profile
  end

  def as_json
    {
      email: profile.email
    }
  end

  private

  attr_reader :profile
end
