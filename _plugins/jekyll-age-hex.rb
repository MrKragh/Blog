module Jekyll
  class RenderAgeHexTag < Liquid::Tag

    def initialize(tag_name, date, tokens)
      super
      @date = RenderAgeTag.validate_date(date)
    end

    def render(context)
      age = RenderAgeTag.get_age(@date)
      hex_age = "0x#{age.to_s(16).upcase}"
      "#{hex_age}"
    end

    def self.validate_date(date)
      Date.parse(date.to_s)
    end

    def self.get_age(from, to = Date.today)
      years = to.year - from.year
      if to.yday < from.yday
        years -= 1
      end
      return years;
    end
  end
end

Liquid::Template.register_tag('agehex', Jekyll::RenderAgeHexTag)