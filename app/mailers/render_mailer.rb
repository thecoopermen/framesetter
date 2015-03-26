class RenderMailer < ApplicationMailer

  def completion_email(export)
    @export = export
    mail to: 'foo@example.com', subject: 'Your comps are ready'
  end
end
