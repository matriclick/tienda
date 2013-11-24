class DeleteFakeEmailsAgain < ActiveRecord::Migration
  def up
    @hard_bounced = User.where("email like '%siham.y.jorge@hotmail.com%' or
    email like '%camila@motosafe.cl%' or
    email like '%elisa.ryhanen@wal-mart.com%' or
    email like '%claudiaberti@costaflora.cl%' or
    email like '%lebon@inbox.com%' or
    email like '%robert_gonzalez26@hotmail.com%' or
    email like '%app+50j8kf8mhk.15upjfb.99df01e5a85ac419170759b8f5aff3e4@proxymail.facebook.com%' or
    email like '%beatriz@baeza.cl%' or
    email like '%cillanes@inecon.net%' or
    email like '%william.gysling@acender.cl%' or
    email like '%ricardo.silva@alifrut.cl%' or
    email like '%ozwaldon@masreggaetonflow.com%' or
    email like '%killer.666@death.la%' or
    email like '%daddy_yankee@fanclub.com%' or
    email like '%jose.margozzini@skrental.com%' or
    email like '%fvaldes@uddd.cl%' or
    email like '%wsilva@koorina.comc%' or
    email like '%abigailnovoa@latinmail.com%' or
    email like '%francisca.estefania@hotmail.wa%' or
    email like '%n.aturaalife@htmail.com%' or
    email like '%kariiito16@otmail.com%' or
    email like '%ale_12802@hotmal.com%' or
    email like '%maxburgos@hotmeil.com%' or
    email like '%valentina_a@gamil.cl%' or
    email like '%karinagalvez494@gamail.com%' or
    email like '%camilafernora.f.a@gmai.com%' or
    email like '%michel_1234@outlook.cl%' or
    email like '%chucha@gmail.cosm%' or
    email like '%vale_madiva@gmai.com%' or
    email like '%catitaottone@123mail.cl%' or
    email like '%mely.xika19@htomail.com%' or
    email like '%quiroga_268_11@hhotmail.com%' or
    email like '%sweetgirl_titi@hotmail.com%' or
    email like '%d.sanhueza@latinmail.com%' or
    email like '%yasniithaa_x@homail.com%' or
    email like '%javythafuentes@gmail.cl%' or
    email like '%zacrika24@homtail.com%' or
    email like '%jdfdhfkzhsd@hotmailg.com%' or
    email like '%camilasanhueza@lice.com%' or
    email like '%oweoiewewwoq@jotmail.com%' or
    email like '%vicky_orreita@xn--hotmail-7va.cl%' or
    email like '%pancho.1969.paz@gamail.com%' or
    email like '%rbm@diguiguin.com%' or
    email like '%bekitaaa@facebook.com%' or
    email like '%belen_1234@outlook.cl%' or
    email like '%piacare2008@gmail.com%' or
    email like '%luis@hotmail.com%' or
    email like '%unik.djal@gmail.com%' or
    email like '%manuel@hotmail.com%' or
    email like '%alvarezgonzalez.na@gmiaal.com%' or
    email like '%ko@hotmail.com%' or
    email like '%sa@hotmail.com%' or
    email like '%da@hotmail.com%' or
    email like '%paaratyy@gmai.com%' or
    email like '%lokyto-delrealggggg_@gmail.cpom%' or
    email like '%tx.ckamiillithax@hotamil.com%' or
    email like '%alicia@hotmail.com%' or
    email like '%mujer@hotmail.com%' or
    email like '%lliyo_gt@live.c%' or
    email like '%navidad@hotmail.com%' or
    email like '%domini26@latinmail.com%' or
    email like '%juoravidlopez@ubicar.com%' or
    email like '%erick1243@quetevalga.com%' or
    email like '%merenguesoyyo@hotmail.com.a%' or
    email like '%natalyven@terra.com%' or
    email like '%kari.genial@hotmail.com%' or
    email like '%cascanueces.loaita@hotmal.coim%' or
    email like '%xik_4decadas@htmail.com%' or
    email like '%pamelita_regia80@hotail.com%' or
    email like '%pinuerisima@gmai.com%'");
    
    @hard_bounced.each do |user|
      puts user.email
      user.destroy
    end
    
  end

  def down
  end
end
