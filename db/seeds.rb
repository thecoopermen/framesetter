Dir[File.join(File.dirname(__FILE__), 'frames', '**')].each do |dir|
  frameset = Frameset.where(name: File.basename(dir).titleize).first_or_create!
  puts "=> processing '#{frameset.name}'"
  Dir[File.join(dir, '*')].each do |file|
    frame = frameset.frames.where(name: File.basename(file, '.*').titleize).first_or_create!
    puts "  -> processing '#{frame.name}'"
    frame.update_attribute(:image, File.open(file))
  end
end
