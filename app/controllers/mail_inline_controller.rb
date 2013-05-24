# encoding: UTF-8
class MailInlineController < ApplicationController
  def i_want_it
    @mail_inline = MailInline.new
    @mail_inline.dress_id = params[:dress_id]
    @mail_inline.dress_url = dress_url(:id => params[:dress_id])
    @mail_inline.message = '¡Hola! si me quieres regalar algo, te lo hago simple, ¡esta es una buena alternativa! lo compras por Matriclick y luego lo recibes en la puerta de tu casa. Si no me queda bien, no te preocupes lo puedo cambiar por otro o simplemente pedir la devolución del dinero.'
    @dress = Dress.find(@mail_inline.dress_id)
    @mail_inline.dress_image_url = ('http://' + request.host_with_port + @dress.dress_images.first.dress.url(:main)).gsub(' ', '%20')
    render :layout => false
  end

  def send_i_want_it
    @mail_inline = MailInline.new(params[:mail_inline])
    if @mail_inline.valid?
      UserMailer.send_i_want_it(@mail_inline).deliver
      redirect_to dress_path(:id => @mail_inline.dress_id), :notice => "Listo! Ya se envió un mail a #{@recipient_email} con tu petición!"
    else
      render :action => 'i_want_it'
    end    
  end

end
