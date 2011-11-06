require "nokogiri"
require "fileutils"

class ResolumeComposition
  attr_accessor :composition
  
  def initialize(composition)
    @composition = composition
    f = File.open(composition)
    @doc = Nokogiri::XML(f)
    f.close
  end
  
  def clips
    @doc.xpath("//deck/clip/videoClip")
  end
  
  def clip_info(clip)
    path = clip.xpath("source").first["name"]
    codec = clip.xpath("settings").first["desc"]
    "#{path} \n#{codec}\n\n"
  end

  def clips_info
    clips.each do |clip|
      puts clip_info(clip)
    end
  end

  def copy_clip(clip, dir)
    src = clip.xpath("source").first["name"]
    filename = clip.xpath("source").first["shortName"]
    unless File.exist?("#{dir}/#{filename}")
      FileUtils.cp(src, dir)
    end
    clip.xpath("source").first["name"] = "#{dir}/#{filename}"
  end
  
  def save(name)
    File.open(name,'w') {|f| @doc.write_xml_to f}
  end
  
  def copy_clips(dir)
    clips.each do |clip|
      copy_clip(clip, dir)
    end
    name = "new_" + composition
    save(name)
  end
    
end