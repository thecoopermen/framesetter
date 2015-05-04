class RenderMailer < ApplicationMailer

  def completion_email(export)
    @export = export
    mail to: export.user.email, subject: 'Your comps are framed!'
  end
end
