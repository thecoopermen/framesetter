class RenderCompsWorker
  include Sidekiq::Worker

  def perform(export_id)
    @export = Export.find(export_id)
    @export.renders.destroy_all
    JSON.parse(@export.selections).each do |selection|
      render_selection(selection)
    end
    RenderMailer.completion_email(@export).deliver_now
  end

  def render_selection(selection)
    frame = Frame.find(selection['frameId'])
    comp = Comp.find(selection['compId'])

    frame_data = open(frame.image.url(:"original_#{selection['rotation']}")).read
    comp_data = open(comp.image.url(:original)).read

    frame_image = Magick::Image.from_blob(frame_data).first
    comp_image = Magick::Image.from_blob(comp_data).first

    comp_image = comp_image.resize_to_fit(frame.send(:"original_#{selection['rotation']}_width"), 0)
    comp_image = comp_image.crop(0, 0, comp_image.columns, frame.send(:"original_#{selection['rotation']}_top") + frame.send(:"original_#{selection['rotation']}_height") + selection['offset'])

    output_file = Tempfile.new('render_comps')
    begin
      mixed = frame_image.composite(
        comp_image,
        frame.send(:"original_#{selection['rotation']}_left"),
        frame.send(:"original_#{selection['rotation']}_top") - selection['offset'],
        Magick::DstOverCompositeOp
      )
      mixed.write(output_file.path)
      @export.renders.create!(
        frame: frame,
        comp: comp,
        rotation: selection['rotation'],
        offset: selection['offset'],
        image: output_file
      )
    ensure
      output_file.close
      output_file.unlink
    end
  end
end
