class Feature
  def self.enabled?(feature)
    ENV["#{feature.to_s.upcase}_ENABLED"] == "true"
  end

  def self.disabled?(feature)
    !enabled?(feature)
  end
end
