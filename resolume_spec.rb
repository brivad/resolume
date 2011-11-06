require "./resolume"

describe "ResolumeComposition" do
  
  subject { ResolumeComposition.new("demo.avc") }
  
  it "loads a composition file" do
     subject.composition.should == "demo.avc"
  end
  
  it "locate the clips" do
    subject.clips.count.should == 17
  end
  
  it "shows clips info" do
    subject.clip_info(subject.clips.first).should == "/Projecten/Avenue/Installers/rev990/Avenue Files/Applications/Resolume Avenue 3 Beta rev990/media/ACC_UrbanTextures_019_av.avi \nCinepak\r\n640x480, 25FPS, 00:03:720\n\n"
  end
  
  it "copies the clip in a given path" do
    subject.copy_clip(subject.clips.first, "copied clips/")
    subject.clip_info(subject.clips.first).should == "copied clips/ACC_UrbanTextures_019_av.avi \nCinepak\r\n640x480, 25FPS, 00:03:720\n\n"
  end
  
  it "saves the new composition with edited paths" do
    subject.copy_clip(subject.clips.last, "copied clips/")
    name = "new_" + subject.composition
    subject.save(name)
    newcomp = ResolumeComposition.new(name)
    newcomp.clip_info(subject.clips.last).should == "copied clips/shinetext.qtz \nQuartz Composition\r\n640x480, 60FPS, 00:05:000\n\n"
  end
  
end

# 
# f = File.open("demo.avc")
# doc = Nokogiri::XML(f)
# f.close
# 
# doc.xpath("//deck/clip/videoClip").first.xpath("source").first["name"]
# doc.xpath("//deck/clip/videoClip").first.xpath("source").first["ext"]
# 
# doc.xpath("//deck/clip/videoClip").first.xpath("settings").first["desc"]