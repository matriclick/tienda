# coding: utf-8

puts "--> Tipos de industria:"
aux = []
aux << IndustryCategoryType.find_or_create_by_name("Productos")
aux << IndustryCategoryType.find_or_create_by_name("Servicios")
aux << IndustryCategoryType.find_or_create_by_name("Servicios a Domicilio")
aux << IndustryCategoryType.find_or_create_by_name("Especiales")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Roles:"
aux = []
aux << Role.find_or_create_by_name("admin")
aux << Role.find_or_create_by_name("user")
aux << Role.find_or_create_by_name("guest")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Contact Types:"
aux = []
aux << ContactType.find_or_create_by_name("Gerente")
aux << ContactType.find_or_create_by_name("Ventas")
aux << ContactType.find_or_create_by_name("Relaciones Públicas")
aux << ContactType.find_or_create_by_name("Reclamos")
aux << ContactType.find_or_create_by_name("Dueño")
aux << ContactType.find_or_create_by_name("Otro")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Days:"
aux = []
aux << Day.find_or_create_by_day_number("1")
aux << Day.find_or_create_by_day_number("2")
aux << Day.find_or_create_by_day_number("3")
aux << Day.find_or_create_by_day_number("4")
aux << Day.find_or_create_by_day_number("5")
aux << Day.find_or_create_by_day_number("6")
aux << Day.find_or_create_by_day_number("7")
aux.each { |x| puts x.day_number }
puts "\n"

puts "--> Shedule Day Types:"
aux = []
aux << ScheduleDayType.find_or_create_by_name("Oficina")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Rent Types:"
aux = []
aux << RentType.find_or_create_by_name("Total")
aux << RentType.find_or_create_by_name("Por Persona")
aux.each { |x| puts x.name }
puts "\n"

# FGM: Event colors
puts "--> Color Types:"
aux = []
aux << ColorType.find_or_create_by_name("Rojo")
aux << ColorType.find_or_create_by_name("Azul")
aux << ColorType.find_or_create_by_name("Verde")
aux << ColorType.find_or_create_by_name("Amarillo")
aux << ColorType.find_or_create_by_name("Morado")
aux << ColorType.find_or_create_by_name("Naranjo")
aux.each { |x| puts x.name }
puts "\n"

#RLS: Age ranges
puts "--> Ages:"
aux = []
aux << Age.find_or_create_by_range("0 - 14")
aux << Age.find_or_create_by_range("15 - 18")
aux << Age.find_or_create_by_range("19 - 25")
aux << Age.find_or_create_by_range("26 - 35")
aux << Age.find_or_create_by_range("36 - 45")
aux << Age.find_or_create_by_range("45 +")
aux.each { |x| puts x.range }
puts "\n"

#RLS: Genders
puts "--> Genders:"
aux = []
aux << Gender.find_or_create_by_gender("H")
aux << Gender.find_or_create_by_gender("M")
aux.each { |x| puts x.gender }
puts "\n"

#RLS:InviteeStatus statuses
puts "--> Statuses:"
aux = []
aux << Status.find_or_create_by_status("Participación")
aux << Status.find_or_create_by_status("Comida")
aux << Status.find_or_create_by_status("Sólo Fiesta")
aux << Status.find_or_create_by_status("Por definir")
aux.each { |x| puts x.status }
puts "\n"

#RLS: Couples names
puts "--> Couples:"
aux = []
aux << Couple.find_or_create_by_name("Marido")
aux << Couple.find_or_create_by_name("Señora")
aux << Couple.find_or_create_by_name("+1")
aux << Couple.find_or_create_by_name("Sin Pareja")
aux.each { |x| puts x.name }
puts "\n"

#RLS: Invitee Hosts names
puts "--> Invitee Hosts:"
aux = []
aux << InviteeHost.find_or_create_by_name("Novia")
aux << InviteeHost.find_or_create_by_name("Novio")
aux << InviteeHost.find_or_create_by_name("Papás Novia")
aux << InviteeHost.find_or_create_by_name("Papás Novio")
aux.each { |x| puts x.name }
puts "\n"

#InviteeGroup names
puts "--> Default Invitee Groups:"
aux = []
aux << DefaultInviteeGroup.find_or_create_by_name("Familia")
aux << DefaultInviteeGroup.find_or_create_by_name("Mejores Amigos")
aux << DefaultInviteeGroup.find_or_create_by_name("Oficina")
aux << DefaultInviteeGroup.find_or_create_by_name("Universidad")
aux << DefaultInviteeGroup.find_or_create_by_name("Colegio")
aux << DefaultInviteeGroup.find_or_create_by_name("Ninguno")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Invitee Roles:"
aux = []
aux << InviteeRole.find_or_create_by_name("Madrina")
aux << InviteeRole.find_or_create_by_name("Padrino")
aux << InviteeRole.find_or_create_by_name("Mamá del Novio")
aux << InviteeRole.find_or_create_by_name("Papá del Novio")
aux << InviteeRole.find_or_create_by_name("Mamá de la Novia")
aux << InviteeRole.find_or_create_by_name("Papá de la Novia")
aux << InviteeRole.find_or_create_by_name("Hermano del Novio")
aux << InviteeRole.find_or_create_by_name("Hermana del Novio")
aux << InviteeRole.find_or_create_by_name("Hermano de la Novia")
aux << InviteeRole.find_or_create_by_name("Hermana de la Novia")
aux << InviteeRole.find_or_create_by_name("Ninguno")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Budget Types: "
aux = []
aux << BudgetType.find_or_create_by_name("$")
aux << BudgetType.find_or_create_by_name("$$")
aux << BudgetType.find_or_create_by_name("$$$")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Budget Invitation Types: "
aux = []
aux << BudgetInvitationType.find_or_create_by_name("Por persona invitada a la fiesta")
aux << BudgetInvitationType.find_or_create_by_name("Por persona invitada a la comida")
aux << BudgetInvitationType.find_or_create_by_name("Valor Total")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Budget Ranges:"
aux = []
aux << BudgetRange.find_or_create_by_range("Menos de 3 millones")
aux << BudgetRange.find_or_create_by_range("De 3 a 7 millones")
aux << BudgetRange.find_or_create_by_range("De 7 a 10 millones")
aux << BudgetRange.find_or_create_by_range("De 10 a 15 millones")
aux << BudgetRange.find_or_create_by_range("De 15 a 20 millones")
aux << BudgetRange.find_or_create_by_range("20 + millones")
aux.each { |x| puts x.range }
puts "\n"

# HH Default activities for matrichecklist
puts "--> Default Activities:"
aux = []
aux << (DefaultActivity.find_by_name("Inscríbete en alguna multitienda (para empezar desde ya juntar puntos!)") or DefaultActivity.create(:name => 'Inscríbete en alguna multitienda (para empezar desde ya juntar puntos!)', :weeks_length =>'1', :position => '1', :description =>'Es importante que aprovechen todos estos meses previos para tener ahorros, una forma es inscribiendose cuanto antes con alguna multitienda, de esta forma les podrán dar a sus conocido el autoadhesivo con su código de novios, para que cada compra que ellos realicen a ustedes les reporte!'))
aux << (DefaultActivity.find_by_name("Haz una lista tentativa de los invitados.") or DefaultActivity.create(:name => 'Haz una lista tentativa de los invitados.', :weeks_length =>'0,5', :position => '2', :description =>'Definan entre los dos una lista tentativa de invitados, piensen que en el camino siempre puede ir apareciendo nuevos, pero para comenzar a buscar centro de eventos e iglesia, deben tener un rango estimado. '))
aux << (DefaultActivity.find_by_name("Define un Presupuesto estimado.") or DefaultActivity.create(:name => 'Define un Presupuesto estimado.', :weeks_length =>'1', :position => '3', :description =>'Definan entre los dos cual es el presupuesto que manejan y cuanto están dispuesto a destinar para su matrimonio, recuerden que aún quedan algunos meses donde pueden crear una cuenta conjunta e ir ahorrando mes a mes'))
aux << (DefaultActivity.find_by_name("Decide una fecha tentativa para la ceremonia religiosa.") or DefaultActivity.create(:name => 'Decide una fecha tentativa para la ceremonia religiosa.', :weeks_length =>'0,5', :position => '4', :description =>'La iglesia debe ser la parroquia de uno de los dos novios. Si desean celebrar su matrimonio en otra iglesia, necesitan una carta de autorización de los párrocos correspondientes. '))
aux << (DefaultActivity.find_by_name("Busca y reserva iglesia  y un sacerdote, pastor o rabino que oficie tu ceremonia.") or DefaultActivity.create(:name => 'Busca y reserva iglesia  y un sacerdote, pastor o rabino que oficie tu ceremonia.', :weeks_length =>'0,5', :position => '5', :description =>'Juntos deben decidir una fecha tentativa para el día de la ceremonia religiosa, piensen siempre en una fecha en la cual tengan tiempo suficiente para organizar todo el matrimonio como lo tenian pensado.'))
aux << (DefaultActivity.find_by_name("Cotiza y reserva el Centro de Eventos.") or DefaultActivity.create(:name => 'Cotiza y reserva el Centro de Eventos.', :weeks_length =>'1', :position => '6', :description =>'Puede verificar en la herramienta "Calendario", la disponibilidad de los proveedores que estén inscritos en Matriclick. Recuerda que  debe coincidir tanto con la cantidad de invitados estimada y la fecha tentativa de la Iglesia.'))
aux << (DefaultActivity.find_by_name("Cotiza y contrata un servicio de banquetería.") or DefaultActivity.create(:name => 'Cotiza y contrata un servicio de banquetería.', :weeks_length =>'0,5', :position => '7', :description =>'Muchas veces este puede venir en convenio exclusivo con el centro de eventos  de no ser así busca el que esté disponible en la fecha tentativa, y comienza a cotizar pregunta por los diferentes menús y el precio por persona.'))
aux << (DefaultActivity.find_by_name("Cotiza y contrata Música para la Fiesta.") or DefaultActivity.create(:name => 'Cotiza y contrata Música para la Fiesta.', :weeks_length =>'0,5', :position => '8', :description =>'La Música puede ser un elemento clave en tu Matrimonio!, por esto busca y cotiza para tu fecha tentativa. También puedes incorporar a este presupuesto una orquesta, animación en vivo o algún elemento especial que quieras en tu matrimonio'))
aux << (DefaultActivity.find_by_name("Define una fecha para el matrimonio civil y pide hora en el Registro Civil.") or DefaultActivity.create(:name => 'Define una fecha para el matrimonio civil y pide hora en el Registro Civil.', :weeks_length =>'1', :position => '9', :description =>'El Matrimonio Civil se celebra ante un funcionario señalado legalmente con dos testigos mayores de edad y se deberá acreditar previamente que se reúnen los requisitos de capacidad exigidos legalmente. Pueden coordinar para que sea en el registro civil o en tu domicilio. A partir de está unión ya pueden empezar a ver un plan de isapre conjunto.'))
aux << (DefaultActivity.find_by_name("Fija fecha y lugar para la postura de argollas. También debes buscar un sacerdotes que las bendiga.") or DefaultActivity.create(:name => 'Fija fecha y lugar para la postura de argollas. También debes buscar un sacerdotes que las bendiga.', :weeks_length =>'1', :position => '10', :description =>'Definan entre los dos la fecha en la cual se pondrán las argollas, esto puede ser una pequeña o gran  ceremonia en el lugar que ustedes eligan, donde un sacerdote bendiga las argollas.'))
aux << (DefaultActivity.find_by_name("Cotiza y manda a hacer las argollas.") or DefaultActivity.create(:name => 'Cotiza y manda a hacer las argollas.', :weeks_length =>'1', :position => '11', :description =>'Deben buscar argollas que sean del gusto de los dos, y ojo con las medidas de cada uno!'))
aux << (DefaultActivity.find_by_name("Cotiza y contrata un Fotográfo y Video para el día del Matrimonio.") or DefaultActivity.create(:name => 'Cotiza y contrata un Fotográfo y Video para el día del Matrimonio.', :weeks_length =>'1', :position => '12', :description =>'Las fotos y el video el día de tu matrimonio es fundamental, ya que plasmará ese día en imagen y será el único recuerdo que tendrán para sus hijos y nietos!'))
aux << (DefaultActivity.find_by_name("Cotiza y contrata Coro para la ceremonia religiosa.") or DefaultActivity.create(:name => 'Cotiza y contrata Coro para la ceremonia religiosa.', :weeks_length =>'1', :position => '13', :description =>'Definan juntos como quieren que sea el coro de la ceremonia religiosa, cuantos instrumentos, cuantas voces, y que ambiente quieren crear; alegre, solemne, etc.'))
aux << (DefaultActivity.find_by_name("Cotiza y contrata Flores para la Ceremonia Religiosa y el Ramo.") or DefaultActivity.create(:name => 'Cotiza y contrata Flores para la Ceremonia Religiosa y el Ramo.', :weeks_length =>'1', :position => '14', :description =>'En la mayoría de los casos la banquetera se encarga de la decoración de la mesas y el espacio. No así de la Iglesia por esto eligan las flores que más les gustan y hagan juego con el  ramo de la novia.'))
aux << (DefaultActivity.find_by_name("Reserva hora a la peluquería y maquillador.") or DefaultActivity.create(:name => 'Reserva hora a la peluquería y maquillador.', :weeks_length =>'2', :position => '15', :description =>'Empieza a cotizar peluquerias y maquilladoras que estén disponibles para el día de tu matrimonio, cómo aún no sabes cómo será el vestido, no eligas el peinado o tocado, simplemente busca alguién que te acomode y entienda lo que buscas.'))
aux << (DefaultActivity.find_by_name("Cotiza partes de matrimonio, tarjetas de agradecimiento y recuerdos de matrimonio.") or DefaultActivity.create(:name => 'Cotiza partes de matrimonio, tarjetas de agradecimiento y recuerdos de matrimonio.', :weeks_length =>'2', :position => '16', :description =>'Matriclick te ofrece la alternativa de enviar partes virtuales sincronizando con la lista de invitados, y de esta forma también permitirles confirmar online. De todas formas siempre van a existir los que prefieren el parte físico, busca el diseño que más te guste y también el material es importante, busquen algo de ustedes, que los represente como pareja.'))
aux << (DefaultActivity.find_by_name("Cotiza y define dónde irán de luna de miel.") or DefaultActivity.create(:name => 'Cotiza y define dónde irán de luna de miel.', :weeks_length =>'3', :position => '17', :description =>'Reviza tu presupuesto, revisa tus puntos, tus millas! Todo sirve, toma en cuenta que los puntos que empieces a juntar con tu código novios también aportan. Muchas veces es mejor comprar anticipadamente ya que pueden aprovechar alguna oferta puntual.'))
aux << (DefaultActivity.find_by_name("Descanso.") or DefaultActivity.create(:name => 'Descanso.', :weeks_length =>'4', :position => '18', :description =>'Quisimos darte este decsanso ya que los  2 primeros meses, pueden ser un poco estresantes, poder coordinar todo lo que tiene relación con la fecha  principalmente, y empezar a cotizar y reservar.  '))
aux << (DefaultActivity.find_by_name("Cotiza y contrata Transporte para el día del Matrimonio.") or DefaultActivity.create(:name => 'Cotiza y contrata Transporte para el día del Matrimonio.', :weeks_length =>'1', :position => '19', :description =>'Llegó el día del matrimonio, todos están nerviosos, es mejor contratar un servicio externo para que lleve a la novia. Pueden elegir el auto, carreta, burrita o la modalidad que ustedes quieran.'))
aux << (DefaultActivity.find_by_name("Coordina la compra del vino y los licores para el matrimonio.") or DefaultActivity.create(:name => 'Coordina la compra del vino y los licores para el matrimonio.', :weeks_length =>'1', :position => '20', :description =>'Las banqueteras por lo general se encargan de este rubro, pero en la mayoria de los casos, el Whisky y el Vino lo deben coordinar los novios de forma externa. '))
aux << (DefaultActivity.find_by_name("Cotiza y coordina las fechas para la pruebas del vestido de novia.") or DefaultActivity.create(:name => 'Cotiza y coordina las fechas para la pruebas del vestido de novia.', :weeks_length =>'1', :position => '21', :description =>'El día que te entregaron el anillo, quizás estabamos con unos kilitos de más, es por esto que no debes dejar este punto para el comienzo. Recuerda que es muy importante elegir un vestido  que te guste pero también que te quede espectacular!, muchas veces el vestido de tus sueños no es el que mejor te queda, por esto tomate el tiempo para probarte diferentes opciones. '))
aux << (DefaultActivity.find_by_name("Coordina qué tipo de traje usará el novio.") or DefaultActivity.create(:name => 'Coordina qué tipo de traje usará el novio.', :weeks_length =>'1', :position => '22', :description =>'El novio debe buscar el estilo que más le acomode, puede ser un traje convencional, smoking, frac, pingüino, etc. Y decidir  si lo va a comprar, mandar a hacer o bien arrendar.'))
aux << (DefaultActivity.find_by_name("Empieza a realizar las charlas matrimoniales.") or DefaultActivity.create(:name => 'Empieza a realizar las charlas matrimoniales.', :weeks_length =>'1', :position => '23', :description =>'Antes del matrimonio, ambos deben asistir a charlas de preparación dictadas por parejas de la misma parroquia, cuya duración mínima es de cuatro sesiones.'))
aux << (DefaultActivity.find_by_name("Cotiza y reserva hora en centros de estética.") or DefaultActivity.create(:name => 'Cotiza y reserva hora en centros de estética.', :weeks_length =>'1', :position => '24', :description =>'Es importante que para el día de su matrimonio estén impecables; con un buen color de piel, una piel suave y exfoliada, y que los nervios no les ganen ese día. Verifiquen en los centros de estética las infinitas opciones que tienen.'))
aux << (DefaultActivity.find_by_name("Cotiza y adquiere los accesorios necesarios.") or DefaultActivity.create(:name => 'Cotiza y adquiere los accesorios necesarios.', :weeks_length =>'1', :position => '25', :description =>'Detalles como las joyas que utilizarás ese día, ropa interior, zapatos, y todo los que te hará lucir radiante!'))
aux << (DefaultActivity.find_by_name("Define dónde vivirán una vez casados.") or DefaultActivity.create(:name => 'Define dónde vivirán una vez casados.', :weeks_length =>'5', :position => '26', :description =>'Comprar o arrendar?, casa o departamento?, cerca del metro?...y todas esas preguntas que deben hacerse para comenzar a vivir juntos! Recuerda que en caso de que quisieran arrendar una propiedad deben cumplir con una serie de requisitos, como demostrar renta 3 veces mayor al valor del arriendo, 3 últimas liquidaciones de sueldo etc.'))
aux << (DefaultActivity.find_by_name("Define y cotiza servicios opcionales para tu matrimonio.") or DefaultActivity.create(:name => 'Define y cotiza servicios opcionales para tu matrimonio.', :weeks_length =>'1', :position => '27', :description =>'Servicios opcionales cómo, carritos de comida, cordero, cabina de garbación de mensajes e incluso clases de vals o bailes para aquellos novios más descordinados.'))
aux << (DefaultActivity.find_by_name("Haz la lista definitiva de invitados y de participaciones.") or DefaultActivity.create(:name => 'Haz la lista definitiva de invitados y de participaciones.', :weeks_length =>'1,5', :position => '28', :description =>'Ya cada vez queda menos tiempo, y deben empezar a cerrar los presupuestis definitivos. Con la Herramienta "Invitados" pueden empezar a armar su lista final de invitados. Participación no es lo mismo que la invitación, ésta sólo comunica la Feliz unión entre ustedes, entregando los detalles de la ceremonia religiosa.'))
aux << (DefaultActivity.find_by_name("Manda a hacer los partes y tarjetas de agradecimiento.") or DefaultActivity.create(:name => 'Manda a hacer los partes y tarjetas de agradecimiento.', :weeks_length =>'1', :position => '29', :description =>'Recuerda que los partes siempren deben llevar  los nombres de los novios, los de sus padres, el lugar, la fecha y la hora de la ceremonia, las direcciones y/o los teléfonos de ambas familias y opcionalmente la petición de confirmación de asistencia, en este caso si envías los partes por Matriclick podrás agregar el link para confirmar online. Puedes incluir en la misma tarjeta el lugar de la celebración, con un pequeño mapa de referencia.'))
aux << (DefaultActivity.find_by_name("Cotiza y reserva Hotel para tu noche de bodas.") or DefaultActivity.create(:name => 'Cotiza y reserva Hotel para tu noche de bodas.', :weeks_length =>'2', :position => '30', :description =>'Busca un lugar agradable y romántico para pasar tu noche de bodas, les recomendamos que no tengan que recorrer mucho desde el el centro de eventos hasta este lugar.'))
aux << (DefaultActivity.find_by_name("Envía los partes.") or DefaultActivity.create(:name => 'Envía los partes.', :weeks_length =>'1', :position => '31', :description =>'Los partes por lo general se deben enviar 45 días antes del día del Matrimonio. En el caso de que envien partes al extranjero recuerden de enviarlos con mayor anticipación. Si envian partes virtuales, es importante verificar que los mails estén correctos.'))
aux << (DefaultActivity.find_by_name("Elige el repertorio del coro y de la música para la fiesta.") or DefaultActivity.create(:name => 'Elige el repertorio del coro y de la música para la fiesta.', :weeks_length =>'2', :position => '32', :description =>'En la ceremonia religiosa la música será el elemento clave para emocionar a nuestros invitados y hacerlos participar, es por esto que la elección tanto del coro como de las canciones es muy importante. Del mismo modo la música en la fiesta siempre debe "hacerlos bailar toda la noche"'))
aux << (DefaultActivity.find_by_name("Confirma fecha y hora de todos los servicios ya contratados.") or DefaultActivity.create(:name => 'Confirma fecha y hora de todos los servicios ya contratados.', :weeks_length =>'1', :position => '33', :description =>'Recuerda que los proveedores es muy importantes que estén coordinados entre ellos, y que se hagan cargo de los tiempos, por ejemplo, el coro debe saber cuando empezar, la banquetera cuando servir, el Dj el vals, y así tu matrimonio funcionará como un reloj!'))
aux << (DefaultActivity.find_by_name("Haz la prueba final y confirma la fecha y hora de entrega del vestido y sus accesorios.") or DefaultActivity.create(:name => 'Haz la prueba final y confirma la fecha y hora de entrega del vestido y sus accesorios.', :weeks_length =>'2', :position => '34', :description =>'Está será la prueba  final del vestido, todo debe quedar perfecto, es por esto que "habla ahora o calla para siempre". Si ya tienes los accesorios recuerda llevarlos para ver como se ven con el vestido.'))
aux << (DefaultActivity.find_by_name("Visita el lugar de la celebración para coordinar el protocolo y afina últimos detalles.") or DefaultActivity.create(:name => 'Visita el lugar de la celebración para coordinar el protocolo y afina últimos detalles.', :weeks_length =>'1', :position => '35', :description =>'Ya conoces el lugar pero siempre hay detalles mínimo que afinar antes del día del matrimonio, por ejemplo por dónde entrarán los novios, por que mesa comenzarán a saludar a sus invitados y miles de detallitos, que es mejor dejarlos listos.'))
aux << (DefaultActivity.find_by_name("Recuerda a quien oficiará la ceremonia, la fecha y el lugar en que se realizará.") or DefaultActivity.create(:name => 'Recuerda a quien oficiará la ceremonia, la fecha y el lugar en que se realizará.', :weeks_length =>'1', :position => '36', :description =>'Confirma con la persona que oficiara tu matrimonio, el día y la hora, ya que entre tantas cosas algo se le podría pasar!'))
aux << (DefaultActivity.find_by_name("Confirma la hora y fecha con el maquillador y peluquero.") or DefaultActivity.create(:name => 'Confirma la hora y fecha con el maquillador y peluquero.', :weeks_length =>'1', :position => '37', :description =>'El día del matrimonio, tu también debes funcionar acorde a tus tiempos y ser puntual con cada servicio que contrataste, es por esto que te conviene confirmar los horarios, no andes corriendo! Siempre es mejor hacer las cosas con calma.'))
aux << (DefaultActivity.find_by_name("Confirma la asistencia de tus invitados y coordina con la banquetera.") or DefaultActivity.create(:name => 'Confirma la asistencia de tus invitados y coordina con la banquetera.', :weeks_length =>'2', :position => '38', :description =>'Entre  2 y 1  semana  antes del día del matrimonio, los novios  ya debieran saber quienes asistirán a su matrimonio'))
aux << (DefaultActivity.find_by_name("Descanso.") or DefaultActivity.create(:name => 'Descanso.', :weeks_length =>'1,5', :position => '39', :description =>'Descansa y relájate hasta el día de tu matrimonio ¡ya está todo listo!'))
aux.each { |x| puts x.name }
puts "\n"


puts "--> Payer Types:"
aux = []
aux << PayerType.find_or_create_by_name("Novio")
aux << PayerType.find_or_create_by_name("Novia")
aux << PayerType.find_or_create_by_name("Padres novio")
aux << PayerType.find_or_create_by_name("Padres novia")
aux << PayerType.find_or_create_by_name("Otro")
aux.each { |x| puts x.name }
puts "\n"

puts "--> Ceremony Types:"
aux = []
aux << CeremonyType.find_or_create_by_name("Civil")
aux << CeremonyType.find_or_create_by_name("Católica")
aux << CeremonyType.find_or_create_by_name("Judía")
aux << CeremonyType.find_or_create_by_name("Evangélica")
aux.each { |x| puts x.name}
puts "\n"

puts "--> Regions and Communes:"
aux = []
aux << (Region.find_by_name("I - Tarapacá") || Region.create(:id => 1, :name => 'I - Tarapacá'))
aux << (Region.find_by_name("II - Antofagasta") || Region.create(:id => 2, :name => 'II - Antofagasta'))
aux << (Region.find_by_name("III - Atacama") || Region.create(:id => 3, :name => 'III - Atacama'))
aux << (Region.find_by_name("IV - Coquimbo") || Region.create(:id => 4, :name => 'IV - Coquimbo'))
aux << (Region.find_by_name("V - Valparaíso") || Region.create(:id => 5, :name => 'V - Valparaíso'))
aux << (Region.find_by_name("VI - O’Higgins") || Region.create(:id => 6, :name => 'VI - O’Higgins'))
aux << (Region.find_by_name("VII - Maule") || Region.create(:id => 7, :name => 'VII - Maule'))
aux << (Region.find_by_name("VIII - Biobío") || Region.create(:id => 8, :name => 'VIII - Biobío'))
aux << (Region.find_by_name("IX - Araucanía") || Region.create(:id => 9, :name => 'IX - Araucanía'))
aux << (Region.find_by_name("X - Los Lagos") || Region.create(:id => 10, :name => 'X - Los Lagos'))
aux << (Region.find_by_name("XI - Aysén") || Region.create(:id => 11, :name => 'XI - Aysén'))
aux << (Region.find_by_name("XII - Magallanes") || Region.create(:id => 12, :name => 'XII - Magallanes'))
aux << (Region.find_by_name("RM - Metropolitana") || Region.create(:id => 13, :name => 'RM - Metropolitana'))
aux << (Region.find_by_name("XIV - Los Ríos") || Region.create(:id => 14, :name => 'XIV - Los Ríos'))
aux << (Region.find_by_name("XV - Arica y Parinacota") || Region.create(:id => 15, :name => 'XV - Arica y Parinacota'))
aux << (Commune.find_by_name("Iquique") || Commune.create(:id => 1101, :name => 'Iquique', :region_id => 1))
aux << (Commune.find_by_name("Alto Hospicio") || Commune.create(:id => 1107, :name => 'Alto Hospicio', :region_id => 1))
aux << (Commune.find_by_name("Pozo Almonte") || Commune.create(:id => 1401, :name => 'Pozo Almonte', :region_id => 1))
aux << (Commune.find_by_name("Camiña") || Commune.create(:id => 1402, :name => 'Camiña', :region_id => 1))
aux << (Commune.find_by_name("Colchane") || Commune.create(:id => 1403, :name => 'Colchane', :region_id => 1))
aux << (Commune.find_by_name("Huara") || Commune.create(:id => 1404, :name => 'Huara', :region_id => 1))
aux << (Commune.find_by_name("Pica") || Commune.create(:id => 1405, :name => 'Pica', :region_id => 1))
aux << (Commune.find_by_name("Antofagasta") || Commune.create(:id => 2101, :name => 'Antofagasta', :region_id => 2))
aux << (Commune.find_by_name("Mejillones") || Commune.create(:id => 2102, :name => 'Mejillones', :region_id => 2))
aux << (Commune.find_by_name("Sierra Gorda") || Commune.create(:id => 2103, :name => 'Sierra Gorda', :region_id => 2))
aux << (Commune.find_by_name("Taltal") || Commune.create(:id => 2104, :name => 'Taltal', :region_id => 2))
aux << (Commune.find_by_name("Calama") || Commune.create(:id => 2201, :name => 'Calama', :region_id => 2))
aux << (Commune.find_by_name("Ollagüe") || Commune.create(:id => 2202, :name => 'Ollagüe', :region_id => 2))
aux << (Commune.find_by_name("San Pedro de Atacama") || Commune.create(:id => 2203, :name => 'San Pedro de Atacama', :region_id => 2))
aux << (Commune.find_by_name("Tocopilla") || Commune.create(:id => 2301, :name => 'Tocopilla', :region_id => 2))
aux << (Commune.find_by_name("María Elena") || Commune.create(:id => 2302, :name => 'María Elena', :region_id => 2))
aux << (Commune.find_by_name("Copiapó") || Commune.create(:id => 3101, :name => 'Copiapó', :region_id => 3))
aux << (Commune.find_by_name("Caldera") || Commune.create(:id => 3102, :name => 'Caldera', :region_id => 3))
aux << (Commune.find_by_name("Tierra Amarilla") || Commune.create(:id => 3103, :name => 'Tierra Amarilla', :region_id => 3))
aux << (Commune.find_by_name("Chañaral") || Commune.create(:id => 3201, :name => 'Chañaral', :region_id => 3))
aux << (Commune.find_by_name("Diego de Almagro") || Commune.create(:id => 3202, :name => 'Diego de Almagro', :region_id => 3))
aux << (Commune.find_by_name("Vallenar") || Commune.create(:id => 3301, :name => 'Vallenar', :region_id => 3))
aux << (Commune.find_by_name("Alto del Carmen") || Commune.create(:id => 3302, :name => 'Alto del Carmen', :region_id => 3))
aux << (Commune.find_by_name("Freirina") || Commune.create(:id => 3303, :name => 'Freirina', :region_id => 3))
aux << (Commune.find_by_name("Huasco") || Commune.create(:id => 3304, :name => 'Huasco', :region_id => 3))
aux << (Commune.find_by_name("La Serena") || Commune.create(:id => 4101, :name => 'La Serena', :region_id => 4))
aux << (Commune.find_by_name("Coquimbo") || Commune.create(:id => 4102, :name => 'Coquimbo', :region_id => 4))
aux << (Commune.find_by_name("Andacollo") || Commune.create(:id => 4103, :name => 'Andacollo', :region_id => 4))
aux << (Commune.find_by_name("La Higuera") || Commune.create(:id => 4104, :name => 'La Higuera', :region_id => 4))
aux << (Commune.find_by_name("Paihuano") || Commune.create(:id => 4105, :name => 'Paihuano', :region_id => 4))
aux << (Commune.find_by_name("Vicuña") || Commune.create(:id => 4106, :name => 'Vicuña', :region_id => 4))
aux << (Commune.find_by_name("Illapel") || Commune.create(:id => 4201, :name => 'Illapel', :region_id => 4))
aux << (Commune.find_by_name("Canela") || Commune.create(:id => 4202, :name => 'Canela', :region_id => 4))
aux << (Commune.find_by_name("Los Vilos") || Commune.create(:id => 4203, :name => 'Los Vilos', :region_id => 4))
aux << (Commune.find_by_name("Salamanca") || Commune.create(:id => 4204, :name => 'Salamanca', :region_id => 4))
aux << (Commune.find_by_name("Ovalle") || Commune.create(:id => 4301, :name => 'Ovalle', :region_id => 4))
aux << (Commune.find_by_name("Combarbalá") || Commune.create(:id => 4302, :name => 'Combarbalá', :region_id => 4))
aux << (Commune.find_by_name("Monte Patria") || Commune.create(:id => 4303, :name => 'Monte Patria', :region_id => 4))
aux << (Commune.find_by_name("Punitaqui") || Commune.create(:id => 4304, :name => 'Punitaqui', :region_id => 4))
aux << (Commune.find_by_name("Río Hurtado") || Commune.create(:id => 4305, :name => 'Río Hurtado', :region_id => 4))
aux << (Commune.find_by_name("Valparaíso") || Commune.create(:id => 5101, :name => 'Valparaíso', :region_id => 5))
aux << (Commune.find_by_name("Casablanca") || Commune.create(:id => 5102, :name => 'Casablanca', :region_id => 5))
aux << (Commune.find_by_name("Concón") || Commune.create(:id => 5103, :name => 'Concón', :region_id => 5))
aux << (Commune.find_by_name("Juan Fernández") || Commune.create(:id => 5104, :name => 'Juan Fernández', :region_id => 5))
aux << (Commune.find_by_name("Puchuncaví") || Commune.create(:id => 5105, :name => 'Puchuncaví', :region_id => 5))
aux << (Commune.find_by_name("Quintero") || Commune.create(:id => 5107, :name => 'Quintero', :region_id => 5))
aux << (Commune.find_by_name("Viña del Mar") || Commune.create(:id => 5109, :name => 'Viña del Mar', :region_id => 5))
aux << (Commune.find_by_name("Isla de Pascua") || Commune.create(:id => 5201, :name => 'Isla de Pascua', :region_id => 5))
aux << (Commune.find_by_name("Los Andes") || Commune.create(:id => 5301, :name => 'Los Andes', :region_id => 5))
aux << (Commune.find_by_name("Calle Larga") || Commune.create(:id => 5302, :name => 'Calle Larga', :region_id => 5))
aux << (Commune.find_by_name("Rinconada") || Commune.create(:id => 5303, :name => 'Rinconada', :region_id => 5))
aux << (Commune.find_by_name("San Esteban") || Commune.create(:id => 5304, :name => 'San Esteban', :region_id => 5))
aux << (Commune.find_by_name("La Ligua") || Commune.create(:id => 5401, :name => 'La Ligua', :region_id => 5))
aux << (Commune.find_by_name("Cabildo") || Commune.create(:id => 5402, :name => 'Cabildo', :region_id => 5))
aux << (Commune.find_by_name("Papudo") || Commune.create(:id => 5403, :name => 'Papudo', :region_id => 5))
aux << (Commune.find_by_name("Petorca") || Commune.create(:id => 5404, :name => 'Petorca', :region_id => 5))
aux << (Commune.find_by_name("Zapallar") || Commune.create(:id => 5405, :name => 'Zapallar', :region_id => 5))
aux << (Commune.find_by_name("Quillota") || Commune.create(:id => 5501, :name => 'Quillota', :region_id => 5))
aux << (Commune.find_by_name("La Calera") || Commune.create(:id => 5502, :name => 'La Calera', :region_id => 5))
aux << (Commune.find_by_name("Hijuelas") || Commune.create(:id => 5503, :name => 'Hijuelas', :region_id => 5))
aux << (Commune.find_by_name("La Cruz") || Commune.create(:id => 5504, :name => 'La Cruz', :region_id => 5))
aux << (Commune.find_by_name("Nogales") || Commune.create(:id => 5506, :name => 'Nogales', :region_id => 5))
aux << (Commune.find_by_name("San Antonio") || Commune.create(:id => 5601, :name => 'San Antonio', :region_id => 5))
aux << (Commune.find_by_name("Algarrobo") || Commune.create(:id => 5602, :name => 'Algarrobo', :region_id => 5))
aux << (Commune.find_by_name("Cartagena") || Commune.create(:id => 5603, :name => 'Cartagena', :region_id => 5))
aux << (Commune.find_by_name("El Quisco") || Commune.create(:id => 5604, :name => 'El Quisco', :region_id => 5))
aux << (Commune.find_by_name("El Tabo") || Commune.create(:id => 5605, :name => 'El Tabo', :region_id => 5))
aux << (Commune.find_by_name("Santo Domingo") || Commune.create(:id => 5606, :name => 'Santo Domingo', :region_id => 5))
aux << (Commune.find_by_name("San Felipe") || Commune.create(:id => 5701, :name => 'San Felipe', :region_id => 5))
aux << (Commune.find_by_name("Catemu") || Commune.create(:id => 5702, :name => 'Catemu', :region_id => 5))
aux << (Commune.find_by_name("Llay Llay") || Commune.create(:id => 5703, :name => 'Llay Llay', :region_id => 5))
aux << (Commune.find_by_name("Panquehue") || Commune.create(:id => 5704, :name => 'Panquehue', :region_id => 5))
aux << (Commune.find_by_name("Putaendo") || Commune.create(:id => 5705, :name => 'Putaendo', :region_id => 5))
aux << (Commune.find_by_name("Santa María") || Commune.create(:id => 5706, :name => 'Santa María', :region_id => 5))
aux << (Commune.find_by_name("Quilpué") || Commune.create(:id => 5801, :name => 'Quilpué', :region_id => 5))
aux << (Commune.find_by_name("Limache") || Commune.create(:id => 5802, :name => 'Limache', :region_id => 5))
aux << (Commune.find_by_name("Olmué") || Commune.create(:id => 5803, :name => 'Olmué', :region_id => 5))
aux << (Commune.find_by_name("Villa Alemana") || Commune.create(:id => 5804, :name => 'Villa Alemana', :region_id => 5))
aux << (Commune.find_by_name("Rancagua") || Commune.create(:id => 6101, :name => 'Rancagua', :region_id => 6))
aux << (Commune.find_by_name("Codegua") || Commune.create(:id => 6102, :name => 'Codegua', :region_id => 6))
aux << (Commune.find_by_name("Coinco") || Commune.create(:id => 6103, :name => 'Coinco', :region_id => 6))
aux << (Commune.find_by_name("Coltauco") || Commune.create(:id => 6104, :name => 'Coltauco', :region_id => 6))
aux << (Commune.find_by_name("Doñihue") || Commune.create(:id => 6105, :name => 'Doñihue', :region_id => 6))
aux << (Commune.find_by_name("Graneros") || Commune.create(:id => 6106, :name => 'Graneros', :region_id => 6))
aux << (Commune.find_by_name("Las Cabras") || Commune.create(:id => 6107, :name => 'Las Cabras', :region_id => 6))
aux << (Commune.find_by_name("Machalí") || Commune.create(:id => 6108, :name => 'Machalí', :region_id => 6))
aux << (Commune.find_by_name("Malloa") || Commune.create(:id => 6109, :name => 'Malloa', :region_id => 6))
aux << (Commune.find_by_name("Mostazal") || Commune.create(:id => 6110, :name => 'Mostazal', :region_id => 6))
aux << (Commune.find_by_name("Olivar") || Commune.create(:id => 6111, :name => 'Olivar', :region_id => 6))
aux << (Commune.find_by_name("Peumo") || Commune.create(:id => 6112, :name => 'Peumo', :region_id => 6))
aux << (Commune.find_by_name("Pichidegua") || Commune.create(:id => 6113, :name => 'Pichidegua', :region_id => 6))
aux << (Commune.find_by_name("Quinta de Tilcoco") || Commune.create(:id => 6114, :name => 'Quinta de Tilcoco', :region_id => 6))
aux << (Commune.find_by_name("Rengo") || Commune.create(:id => 6115, :name => 'Rengo', :region_id => 6))
aux << (Commune.find_by_name("Requínoa") || Commune.create(:id => 6116, :name => 'Requínoa', :region_id => 6))
aux << (Commune.find_by_name("San Vicente") || Commune.create(:id => 6117, :name => 'San Vicente', :region_id => 6))
aux << (Commune.find_by_name("Pichilemu") || Commune.create(:id => 6201, :name => 'Pichilemu', :region_id => 6))
aux << (Commune.find_by_name("La Estrella") || Commune.create(:id => 6202, :name => 'La Estrella', :region_id => 6))
aux << (Commune.find_by_name("Litueche") || Commune.create(:id => 6203, :name => 'Litueche', :region_id => 6))
aux << (Commune.find_by_name("Marchihue") || Commune.create(:id => 6204, :name => 'Marchihue', :region_id => 6))
aux << (Commune.find_by_name("Navidad") || Commune.create(:id => 6205, :name => 'Navidad', :region_id => 6))
aux << (Commune.find_by_name("Paredones") || Commune.create(:id => 6206, :name => 'Paredones', :region_id => 6))
aux << (Commune.find_by_name("San Fernando") || Commune.create(:id => 6301, :name => 'San Fernando', :region_id => 6))
aux << (Commune.find_by_name("Chépica") || Commune.create(:id => 6302, :name => 'Chépica', :region_id => 6))
aux << (Commune.find_by_name("Chimbarongo") || Commune.create(:id => 6303, :name => 'Chimbarongo', :region_id => 6))
aux << (Commune.find_by_name("Lolol") || Commune.create(:id => 6304, :name => 'Lolol', :region_id => 6))
aux << (Commune.find_by_name("Nancagua") || Commune.create(:id => 6305, :name => 'Nancagua', :region_id => 6))
aux << (Commune.find_by_name("Palmilla") || Commune.create(:id => 6306, :name => 'Palmilla', :region_id => 6))
aux << (Commune.find_by_name("Peralillo") || Commune.create(:id => 6307, :name => 'Peralillo', :region_id => 6))
aux << (Commune.find_by_name("Placilla") || Commune.create(:id => 6308, :name => 'Placilla', :region_id => 6))
aux << (Commune.find_by_name("Pumanque") || Commune.create(:id => 6309, :name => 'Pumanque', :region_id => 6))
aux << (Commune.find_by_name("Santa Cruz") || Commune.create(:id => 6310, :name => 'Santa Cruz', :region_id => 6))
aux << (Commune.find_by_name("Talca") || Commune.create(:id => 7101, :name => 'Talca', :region_id => 7))
aux << (Commune.find_by_name("Constitución") || Commune.create(:id => 7102, :name => 'Constitución', :region_id => 7))
aux << (Commune.find_by_name("Curepto") || Commune.create(:id => 7103, :name => 'Curepto', :region_id => 7))
aux << (Commune.find_by_name("Empedrado") || Commune.create(:id => 7104, :name => 'Empedrado', :region_id => 7))
aux << (Commune.find_by_name("Maule") || Commune.create(:id => 7105, :name => 'Maule', :region_id => 7))
aux << (Commune.find_by_name("Pelarco") || Commune.create(:id => 7106, :name => 'Pelarco', :region_id => 7))
aux << (Commune.find_by_name("Pencahue") || Commune.create(:id => 7107, :name => 'Pencahue', :region_id => 7))
aux << (Commune.find_by_name("Río Claro") || Commune.create(:id => 7108, :name => 'Río Claro', :region_id => 7))
aux << (Commune.find_by_name("San Clemente") || Commune.create(:id => 7109, :name => 'San Clemente', :region_id => 7))
aux << (Commune.find_by_name("San Rafael") || Commune.create(:id => 7110, :name => 'San Rafael', :region_id => 7))
aux << (Commune.find_by_name("Cauquenes") || Commune.create(:id => 7201, :name => 'Cauquenes', :region_id => 7))
aux << (Commune.find_by_name("Chanco") || Commune.create(:id => 7202, :name => 'Chanco', :region_id => 7))
aux << (Commune.find_by_name("Pelluhue") || Commune.create(:id => 7203, :name => 'Pelluhue', :region_id => 7))
aux << (Commune.find_by_name("Curicó") || Commune.create(:id => 7301, :name => 'Curicó', :region_id => 7))
aux << (Commune.find_by_name("Hualañé") || Commune.create(:id => 7302, :name => 'Hualañé', :region_id => 7))
aux << (Commune.find_by_name("Licantén") || Commune.create(:id => 7303, :name => 'Licantén', :region_id => 7))
aux << (Commune.find_by_name("Molina") || Commune.create(:id => 7304, :name => 'Molina', :region_id => 7))
aux << (Commune.find_by_name("Rauco") || Commune.create(:id => 7305, :name => 'Rauco', :region_id => 7))
aux << (Commune.find_by_name("Romeral") || Commune.create(:id => 7306, :name => 'Romeral', :region_id => 7))
aux << (Commune.find_by_name("Sagrada Familia") || Commune.create(:id => 7307, :name => 'Sagrada Familia', :region_id => 7))
aux << (Commune.find_by_name("Teno") || Commune.create(:id => 7308, :name => 'Teno', :region_id => 7))
aux << (Commune.find_by_name("Vichuquén") || Commune.create(:id => 7309, :name => 'Vichuquén', :region_id => 7))
aux << (Commune.find_by_name("Linares") || Commune.create(:id => 7401, :name => 'Linares', :region_id => 7))
aux << (Commune.find_by_name("Colbún") || Commune.create(:id => 7402, :name => 'Colbún', :region_id => 7))
aux << (Commune.find_by_name("Longaví") || Commune.create(:id => 7403, :name => 'Longaví', :region_id => 7))
aux << (Commune.find_by_name("Parral") || Commune.create(:id => 7404, :name => 'Parral', :region_id => 7))
aux << (Commune.find_by_name("Retiro") || Commune.create(:id => 7405, :name => 'Retiro', :region_id => 7))
aux << (Commune.find_by_name("San Javier") || Commune.create(:id => 7406, :name => 'San Javier', :region_id => 7))
aux << (Commune.find_by_name("Villa Alegre") || Commune.create(:id => 7407, :name => 'Villa Alegre', :region_id => 7))
aux << (Commune.find_by_name("Yerbas Buenas") || Commune.create(:id => 7408, :name => 'Yerbas Buenas', :region_id => 7))
aux << (Commune.find_by_name("Concepción") || Commune.create(:id => 8101, :name => 'Concepción', :region_id => 8))
aux << (Commune.find_by_name("Coronel") || Commune.create(:id => 8102, :name => 'Coronel', :region_id => 8))
aux << (Commune.find_by_name("Chiguayante") || Commune.create(:id => 8103, :name => 'Chiguayante', :region_id => 8))
aux << (Commune.find_by_name("Florida") || Commune.create(:id => 8104, :name => 'Florida', :region_id => 8))
aux << (Commune.find_by_name("Hualqui") || Commune.create(:id => 8105, :name => 'Hualqui', :region_id => 8))
aux << (Commune.find_by_name("Lota") || Commune.create(:id => 8106, :name => 'Lota', :region_id => 8))
aux << (Commune.find_by_name("Penco") || Commune.create(:id => 8107, :name => 'Penco', :region_id => 8))
aux << (Commune.find_by_name("San Pedro de la Paz") || Commune.create(:id => 8108, :name => 'San Pedro de la Paz', :region_id => 8))
aux << (Commune.find_by_name("Santa Juana") || Commune.create(:id => 8109, :name => 'Santa Juana', :region_id => 8))
aux << (Commune.find_by_name("Talcahuano") || Commune.create(:id => 8110, :name => 'Talcahuano', :region_id => 8))
aux << (Commune.find_by_name("Tomé") || Commune.create(:id => 8111, :name => 'Tomé', :region_id => 8))
aux << (Commune.find_by_name("Hualpén") || Commune.create(:id => 8112, :name => 'Hualpén', :region_id => 8))
aux << (Commune.find_by_name("Lebu") || Commune.create(:id => 8201, :name => 'Lebu', :region_id => 8))
aux << (Commune.find_by_name("Arauco") || Commune.create(:id => 8202, :name => 'Arauco', :region_id => 8))
aux << (Commune.find_by_name("Cañete") || Commune.create(:id => 8203, :name => 'Cañete', :region_id => 8))
aux << (Commune.find_by_name("Contulmo") || Commune.create(:id => 8204, :name => 'Contulmo', :region_id => 8))
aux << (Commune.find_by_name("Curanilahue") || Commune.create(:id => 8205, :name => 'Curanilahue', :region_id => 8))
aux << (Commune.find_by_name("Los Álamos") || Commune.create(:id => 8206, :name => 'Los Álamos', :region_id => 8))
aux << (Commune.find_by_name("Tirúa") || Commune.create(:id => 8207, :name => 'Tirúa', :region_id => 8))
aux << (Commune.find_by_name("Los Ángeles") || Commune.create(:id => 8301, :name => 'Los Ángeles', :region_id => 8))
aux << (Commune.find_by_name("Antuco") || Commune.create(:id => 8302, :name => 'Antuco', :region_id => 8))
aux << (Commune.find_by_name("Cabrero") || Commune.create(:id => 8303, :name => 'Cabrero', :region_id => 8))
aux << (Commune.find_by_name("Laja") || Commune.create(:id => 8304, :name => 'Laja', :region_id => 8))
aux << (Commune.find_by_name("Mulchén") || Commune.create(:id => 8305, :name => 'Mulchén', :region_id => 8))
aux << (Commune.find_by_name("Nacimiento") || Commune.create(:id => 8306, :name => 'Nacimiento', :region_id => 8))
aux << (Commune.find_by_name("Negrete") || Commune.create(:id => 8307, :name => 'Negrete', :region_id => 8))
aux << (Commune.find_by_name("Quilaco") || Commune.create(:id => 8308, :name => 'Quilaco', :region_id => 8))
aux << (Commune.find_by_name("Quilleco") || Commune.create(:id => 8309, :name => 'Quilleco', :region_id => 8))
aux << (Commune.find_by_name("San Rosendo") || Commune.create(:id => 8310, :name => 'San Rosendo', :region_id => 8))
aux << (Commune.find_by_name("Santa Bárbara") || Commune.create(:id => 8311, :name => 'Santa Bárbara', :region_id => 8))
aux << (Commune.find_by_name("Tucapel") || Commune.create(:id => 8312, :name => 'Tucapel', :region_id => 8))
aux << (Commune.find_by_name("Yumbel") || Commune.create(:id => 8313, :name => 'Yumbel', :region_id => 8))
aux << (Commune.find_by_name("Alto Biobío") || Commune.create(:id => 8314, :name => 'Alto Biobío', :region_id => 8))
aux << (Commune.find_by_name("Chillán") || Commune.create(:id => 8401, :name => 'Chillán', :region_id => 8))
aux << (Commune.find_by_name("Bulnes") || Commune.create(:id => 8402, :name => 'Bulnes', :region_id => 8))
aux << (Commune.find_by_name("Cobquecura") || Commune.create(:id => 8403, :name => 'Cobquecura', :region_id => 8))
aux << (Commune.find_by_name("Coelemu") || Commune.create(:id => 8404, :name => 'Coelemu', :region_id => 8))
aux << (Commune.find_by_name("Coihueco") || Commune.create(:id => 8405, :name => 'Coihueco', :region_id => 8))
aux << (Commune.find_by_name("Chillán Viejo") || Commune.create(:id => 8406, :name => 'Chillán Viejo', :region_id => 8))
aux << (Commune.find_by_name("El Carmen") || Commune.create(:id => 8407, :name => 'El Carmen', :region_id => 8))
aux << (Commune.find_by_name("Ninhue") || Commune.create(:id => 8408, :name => 'Ninhue', :region_id => 8))
aux << (Commune.find_by_name("Ñiquén") || Commune.create(:id => 8409, :name => 'Ñiquén', :region_id => 8))
aux << (Commune.find_by_name("Pemuco") || Commune.create(:id => 8410, :name => 'Pemuco', :region_id => 8))
aux << (Commune.find_by_name("Pinto") || Commune.create(:id => 8411, :name => 'Pinto', :region_id => 8))
aux << (Commune.find_by_name("Portezuelo") || Commune.create(:id => 8412, :name => 'Portezuelo', :region_id => 8))
aux << (Commune.find_by_name("Quillón") || Commune.create(:id => 8413, :name => 'Quillón', :region_id => 8))
aux << (Commune.find_by_name("Quirihue") || Commune.create(:id => 8414, :name => 'Quirihue', :region_id => 8))
aux << (Commune.find_by_name("Ránquil") || Commune.create(:id => 8415, :name => 'Ránquil', :region_id => 8))
aux << (Commune.find_by_name("San Carlos") || Commune.create(:id => 8416, :name => 'San Carlos', :region_id => 8))
aux << (Commune.find_by_name("San Fabián") || Commune.create(:id => 8417, :name => 'San Fabián', :region_id => 8))
aux << (Commune.find_by_name("San Ignacio") || Commune.create(:id => 8418, :name => 'San Ignacio', :region_id => 8))
aux << (Commune.find_by_name("San Nicolás") || Commune.create(:id => 8419, :name => 'San Nicolás', :region_id => 8))
aux << (Commune.find_by_name("Treguaco") || Commune.create(:id => 8420, :name => 'Treguaco', :region_id => 8))
aux << (Commune.find_by_name("Yungay") || Commune.create(:id => 8421, :name => 'Yungay', :region_id => 8))
aux << (Commune.find_by_name("Temuco") || Commune.create(:id => 9101, :name => 'Temuco', :region_id => 9))
aux << (Commune.find_by_name("Carahue") || Commune.create(:id => 9102, :name => 'Carahue', :region_id => 9))
aux << (Commune.find_by_name("Cunco") || Commune.create(:id => 9103, :name => 'Cunco', :region_id => 9))
aux << (Commune.find_by_name("Curarrehue") || Commune.create(:id => 9104, :name => 'Curarrehue', :region_id => 9))
aux << (Commune.find_by_name("Freire") || Commune.create(:id => 9105, :name => 'Freire', :region_id => 9))
aux << (Commune.find_by_name("Galvarino") || Commune.create(:id => 9106, :name => 'Galvarino', :region_id => 9))
aux << (Commune.find_by_name("Gorbea") || Commune.create(:id => 9107, :name => 'Gorbea', :region_id => 9))
aux << (Commune.find_by_name("Lautaro") || Commune.create(:id => 9108, :name => 'Lautaro', :region_id => 9))
aux << (Commune.find_by_name("Loncoche") || Commune.create(:id => 9109, :name => 'Loncoche', :region_id => 9))
aux << (Commune.find_by_name("Melipeuco") || Commune.create(:id => 9110, :name => 'Melipeuco', :region_id => 9))
aux << (Commune.find_by_name("Nueva Imperial") || Commune.create(:id => 9111, :name => 'Nueva Imperial', :region_id => 9))
aux << (Commune.find_by_name("Padre las Casas") || Commune.create(:id => 9112, :name => 'Padre las Casas', :region_id => 9))
aux << (Commune.find_by_name("Perquenco") || Commune.create(:id => 9113, :name => 'Perquenco', :region_id => 9))
aux << (Commune.find_by_name("Pitrufquén") || Commune.create(:id => 9114, :name => 'Pitrufquén', :region_id => 9))
aux << (Commune.find_by_name("Pucón") || Commune.create(:id => 9115, :name => 'Pucón', :region_id => 9))
aux << (Commune.find_by_name("Saavedra") || Commune.create(:id => 9116, :name => 'Saavedra', :region_id => 9))
aux << (Commune.find_by_name("Teodoro Schmidt") || Commune.create(:id => 9117, :name => 'Teodoro Schmidt', :region_id => 9))
aux << (Commune.find_by_name("Toltén") || Commune.create(:id => 9118, :name => 'Toltén', :region_id => 9))
aux << (Commune.find_by_name("Vilcún") || Commune.create(:id => 9119, :name => 'Vilcún', :region_id => 9))
aux << (Commune.find_by_name("Villarrica") || Commune.create(:id => 9120, :name => 'Villarrica', :region_id => 9))
aux << (Commune.find_by_name("Cholchol") || Commune.create(:id => 9121, :name => 'Cholchol', :region_id => 9))
aux << (Commune.find_by_name("Angol") || Commune.create(:id => 9201, :name => 'Angol', :region_id => 9))
aux << (Commune.find_by_name("Collipulli") || Commune.create(:id => 9202, :name => 'Collipulli', :region_id => 9))
aux << (Commune.find_by_name("Curacautín") || Commune.create(:id => 9203, :name => 'Curacautín', :region_id => 9))
aux << (Commune.find_by_name("Ercilla") || Commune.create(:id => 9204, :name => 'Ercilla', :region_id => 9))
aux << (Commune.find_by_name("Lonquimay") || Commune.create(:id => 9205, :name => 'Lonquimay', :region_id => 9))
aux << (Commune.find_by_name("Los Sauces") || Commune.create(:id => 9206, :name => 'Los Sauces', :region_id => 9))
aux << (Commune.find_by_name("Lumaco") || Commune.create(:id => 9207, :name => 'Lumaco', :region_id => 9))
aux << (Commune.find_by_name("Purén") || Commune.create(:id => 9208, :name => 'Purén', :region_id => 9))
aux << (Commune.find_by_name("Renaico") || Commune.create(:id => 9209, :name => 'Renaico', :region_id => 9))
aux << (Commune.find_by_name("Traiguén") || Commune.create(:id => 9210, :name => 'Traiguén', :region_id => 9))
aux << (Commune.find_by_name("Victoria") || Commune.create(:id => 9211, :name => 'Victoria', :region_id => 9))
aux << (Commune.find_by_name("Puerto Montt") || Commune.create(:id => 10101, :name => 'Puerto Montt', :region_id => 10))
aux << (Commune.find_by_name("Calbuco") || Commune.create(:id => 10102, :name => 'Calbuco', :region_id => 10))
aux << (Commune.find_by_name("Cochamó") || Commune.create(:id => 10103, :name => 'Cochamó', :region_id => 10))
aux << (Commune.find_by_name("Fresia") || Commune.create(:id => 10104, :name => 'Fresia', :region_id => 10))
aux << (Commune.find_by_name("Frutillar") || Commune.create(:id => 10105, :name => 'Frutillar', :region_id => 10))
aux << (Commune.find_by_name("Los Muermos") || Commune.create(:id => 10106, :name => 'Los Muermos', :region_id => 10))
aux << (Commune.find_by_name("Llanquihue") || Commune.create(:id => 10107, :name => 'Llanquihue', :region_id => 10))
aux << (Commune.find_by_name("Maullín") || Commune.create(:id => 10108, :name => 'Maullín', :region_id => 10))
aux << (Commune.find_by_name("Puerto Varas") || Commune.create(:id => 10109, :name => 'Puerto Varas', :region_id => 10))
aux << (Commune.find_by_name("Castro") || Commune.create(:id => 10201, :name => 'Castro', :region_id => 10))
aux << (Commune.find_by_name("Ancud") || Commune.create(:id => 10202, :name => 'Ancud', :region_id => 10))
aux << (Commune.find_by_name("Chonchi") || Commune.create(:id => 10203, :name => 'Chonchi', :region_id => 10))
aux << (Commune.find_by_name("Curaco de Vélez") || Commune.create(:id => 10204, :name => 'Curaco de Vélez', :region_id => 10))
aux << (Commune.find_by_name("Dalcahue") || Commune.create(:id => 10205, :name => 'Dalcahue', :region_id => 10))
aux << (Commune.find_by_name("Puqueldón") || Commune.create(:id => 10206, :name => 'Puqueldón', :region_id => 10))
aux << (Commune.find_by_name("Queilén") || Commune.create(:id => 10207, :name => 'Queilén', :region_id => 10))
aux << (Commune.find_by_name("Quellón") || Commune.create(:id => 10208, :name => 'Quellón', :region_id => 10))
aux << (Commune.find_by_name("Quemchi") || Commune.create(:id => 10209, :name => 'Quemchi', :region_id => 10))
aux << (Commune.find_by_name("Quinchao") || Commune.create(:id => 10210, :name => 'Quinchao', :region_id => 10))
aux << (Commune.find_by_name("Osorno") || Commune.create(:id => 10301, :name => 'Osorno', :region_id => 10))
aux << (Commune.find_by_name("Puerto Octay") || Commune.create(:id => 10302, :name => 'Puerto Octay', :region_id => 10))
aux << (Commune.find_by_name("Purranque") || Commune.create(:id => 10303, :name => 'Purranque', :region_id => 10))
aux << (Commune.find_by_name("Puyehue") || Commune.create(:id => 10304, :name => 'Puyehue', :region_id => 10))
aux << (Commune.find_by_name("Río Negro") || Commune.create(:id => 10305, :name => 'Río Negro', :region_id => 10))
aux << (Commune.find_by_name("San Juan de la Costa") || Commune.create(:id => 10306, :name => 'San Juan de la Costa', :region_id => 10))
aux << (Commune.find_by_name("San Pablo") || Commune.create(:id => 10307, :name => 'San Pablo', :region_id => 10))
aux << (Commune.find_by_name("Chaitén") || Commune.create(:id => 10401, :name => 'Chaitén', :region_id => 10))
aux << (Commune.find_by_name("Futaleufú") || Commune.create(:id => 10402, :name => 'Futaleufú', :region_id => 10))
aux << (Commune.find_by_name("Hualaihué") || Commune.create(:id => 10403, :name => 'Hualaihué', :region_id => 10))
aux << (Commune.find_by_name("Palena") || Commune.create(:id => 10404, :name => 'Palena', :region_id => 10))
aux << (Commune.find_by_name("Coyhaique") || Commune.create(:id => 11101, :name => 'Coyhaique', :region_id => 11))
aux << (Commune.find_by_name("Lago Verde") || Commune.create(:id => 11102, :name => 'Lago Verde', :region_id => 11))
aux << (Commune.find_by_name("Aysén") || Commune.create(:id => 11201, :name => 'Aysén', :region_id => 11))
aux << (Commune.find_by_name("Cisnes") || Commune.create(:id => 11202, :name => 'Cisnes', :region_id => 11))
aux << (Commune.find_by_name("Guaitecas") || Commune.create(:id => 11203, :name => 'Guaitecas', :region_id => 11))
aux << (Commune.find_by_name("Cochrane") || Commune.create(:id => 11301, :name => 'Cochrane', :region_id => 11))
aux << (Commune.find_by_name("O\'Higgins") || Commune.create(:id => 11302, :name => 'O\'Higgins', :region_id => 11))
aux << (Commune.find_by_name("Tortel") || Commune.create(:id => 11303, :name => 'Tortel', :region_id => 11))
aux << (Commune.find_by_name("Chile Chico") || Commune.create(:id => 11401, :name => 'Chile Chico', :region_id => 11))
aux << (Commune.find_by_name("Río Ibáñez") || Commune.create(:id => 11402, :name => 'Río Ibáñez', :region_id => 11))
aux << (Commune.find_by_name("Punta Arenas") || Commune.create(:id => 12101, :name => 'Punta Arenas', :region_id => 12))
aux << (Commune.find_by_name("Laguna Blanca") || Commune.create(:id => 12102, :name => 'Laguna Blanca', :region_id => 12))
aux << (Commune.find_by_name("Río Verde") || Commune.create(:id => 12103, :name => 'Río Verde', :region_id => 12))
aux << (Commune.find_by_name("San Gregorio") || Commune.create(:id => 12104, :name => 'San Gregorio', :region_id => 12))
aux << (Commune.find_by_name("Cabo de Hornos") || Commune.create(:id => 12201, :name => 'Cabo de Hornos', :region_id => 12))
aux << (Commune.find_by_name("Antártica") || Commune.create(:id => 12202, :name => 'Antártica', :region_id => 12))
aux << (Commune.find_by_name("Porvenir") || Commune.create(:id => 12301, :name => 'Porvenir', :region_id => 12))
aux << (Commune.find_by_name("Primavera") || Commune.create(:id => 12302, :name => 'Primavera', :region_id => 12))
aux << (Commune.find_by_name("Timaukel") || Commune.create(:id => 12303, :name => 'Timaukel', :region_id => 12))
aux << (Commune.find_by_name("Natales") || Commune.create(:id => 12401, :name => 'Natales', :region_id => 12))
aux << (Commune.find_by_name("Torres del Paine") || Commune.create(:id => 12402, :name => 'Torres del Paine', :region_id => 12))
aux << (Commune.find_by_name("Santiago") || Commune.create(:id => 13101, :name => 'Santiago', :region_id => 13))
aux << (Commune.find_by_name("Cerrillos") || Commune.create(:id => 13102, :name => 'Cerrillos', :region_id => 13))
aux << (Commune.find_by_name("Cerro Navia") || Commune.create(:id => 13103, :name => 'Cerro Navia', :region_id => 13))
aux << (Commune.find_by_name("Conchalí") || Commune.create(:id => 13104, :name => 'Conchalí', :region_id => 13))
aux << (Commune.find_by_name("El Bosque") || Commune.create(:id => 13105, :name => 'El Bosque', :region_id => 13))
aux << (Commune.find_by_name("Estación Central") || Commune.create(:id => 13106, :name => 'Estación Central', :region_id => 13))
aux << (Commune.find_by_name("Huechuraba") || Commune.create(:id => 13107, :name => 'Huechuraba', :region_id => 13))
aux << (Commune.find_by_name("Independencia") || Commune.create(:id => 13108, :name => 'Independencia', :region_id => 13))
aux << (Commune.find_by_name("La Cisterna") || Commune.create(:id => 13109, :name => 'La Cisterna', :region_id => 13))
aux << (Commune.find_by_name("La Florida") || Commune.create(:id => 13110, :name => 'La Florida', :region_id => 13))
aux << (Commune.find_by_name("La Granja") || Commune.create(:id => 13111, :name => 'La Granja', :region_id => 13))
aux << (Commune.find_by_name("La Pintana") || Commune.create(:id => 13112, :name => 'La Pintana', :region_id => 13))
aux << (Commune.find_by_name("La Reina") || Commune.create(:id => 13113, :name => 'La Reina', :region_id => 13))
aux << (Commune.find_by_name("Las Condes") || Commune.create(:id => 13114, :name => 'Las Condes', :region_id => 13))
aux << (Commune.find_by_name("Lo Barnechea") || Commune.create(:id => 13115, :name => 'Lo Barnechea', :region_id => 13))
aux << (Commune.find_by_name("Lo Espejo") || Commune.create(:id => 13116, :name => 'Lo Espejo', :region_id => 13))
aux << (Commune.find_by_name("Lo Prado") || Commune.create(:id => 13117, :name => 'Lo Prado', :region_id => 13))
aux << (Commune.find_by_name("Macul") || Commune.create(:id => 13118, :name => 'Macul', :region_id => 13))
aux << (Commune.find_by_name("Maipú") || Commune.create(:id => 13119, :name => 'Maipú', :region_id => 13))
aux << (Commune.find_by_name("Ñuñoa") || Commune.create(:id => 13120, :name => 'Ñuñoa', :region_id => 13))
aux << (Commune.find_by_name("Pedro Aguirre Cerda") || Commune.create(:id => 13121, :name => 'Pedro Aguirre Cerda', :region_id => 13))
aux << (Commune.find_by_name("Peñalolén") || Commune.create(:id => 13122, :name => 'Peñalolén', :region_id => 13))
aux << (Commune.find_by_name("Providencia") || Commune.create(:id => 13123, :name => 'Providencia', :region_id => 13))
aux << (Commune.find_by_name("Pudahuel") || Commune.create(:id => 13124, :name => 'Pudahuel', :region_id => 13))
aux << (Commune.find_by_name("Quilicura") || Commune.create(:id => 13125, :name => 'Quilicura', :region_id => 13))
aux << (Commune.find_by_name("Quinta Normal") || Commune.create(:id => 13126, :name => 'Quinta Normal', :region_id => 13))
aux << (Commune.find_by_name("Recoleta") || Commune.create(:id => 13127, :name => 'Recoleta', :region_id => 13))
aux << (Commune.find_by_name("Renca") || Commune.create(:id => 13128, :name => 'Renca', :region_id => 13))
aux << (Commune.find_by_name("San Joaquín") || Commune.create(:id => 13129, :name => 'San Joaquín', :region_id => 13))
aux << (Commune.find_by_name("San Miguel") || Commune.create(:id => 13130, :name => 'San Miguel', :region_id => 13))
aux << (Commune.find_by_name("San Ramón") || Commune.create(:id => 13131, :name => 'San Ramón', :region_id => 13))
aux << (Commune.find_by_name("Vitacura") || Commune.create(:id => 13132, :name => 'Vitacura', :region_id => 13))
aux << (Commune.find_by_name("Puente Alto") || Commune.create(:id => 13201, :name => 'Puente Alto', :region_id => 13))
aux << (Commune.find_by_name("Pirque") || Commune.create(:id => 13202, :name => 'Pirque', :region_id => 13))
aux << (Commune.find_by_name("San José de Maipo") || Commune.create(:id => 13203, :name => 'San José de Maipo', :region_id => 13))
aux << (Commune.find_by_name("Colina") || Commune.create(:id => 13301, :name => 'Colina', :region_id => 13))
aux << (Commune.find_by_name("Lampa") || Commune.create(:id => 13302, :name => 'Lampa', :region_id => 13))
aux << (Commune.find_by_name("Tiltil") || Commune.create(:id => 13303, :name => 'Tiltil', :region_id => 13))
aux << (Commune.find_by_name("San Bernardo") || Commune.create(:id => 13401, :name => 'San Bernardo', :region_id => 13))
aux << (Commune.find_by_name("Buin") || Commune.create(:id => 13402, :name => 'Buin', :region_id => 13))
aux << (Commune.find_by_name("Calera de Tango") || Commune.create(:id => 13403, :name => 'Calera de Tango', :region_id => 13))
aux << (Commune.find_by_name("Paine") || Commune.create(:id => 13404, :name => 'Paine', :region_id => 13))
aux << (Commune.find_by_name("Melipilla") || Commune.create(:id => 13501, :name => 'Melipilla', :region_id => 13))
aux << (Commune.find_by_name("Alhué") || Commune.create(:id => 13502, :name => 'Alhué', :region_id => 13))
aux << (Commune.find_by_name("Curacaví") || Commune.create(:id => 13503, :name => 'Curacaví', :region_id => 13))
aux << (Commune.find_by_name("María Pinto") || Commune.create(:id => 13504, :name => 'María Pinto', :region_id => 13))
aux << (Commune.find_by_name("San Pedro") || Commune.create(:id => 13505, :name => 'San Pedro', :region_id => 13))
aux << (Commune.find_by_name("Talagante") || Commune.create(:id => 13601, :name => 'Talagante', :region_id => 13))
aux << (Commune.find_by_name("El Monte") || Commune.create(:id => 13602, :name => 'El Monte', :region_id => 13))
aux << (Commune.find_by_name("Isla de Maipo") || Commune.create(:id => 13603, :name => 'Isla de Maipo', :region_id => 13))
aux << (Commune.find_by_name("Padre Hurtado") || Commune.create(:id => 13604, :name => 'Padre Hurtado', :region_id => 13))
aux << (Commune.find_by_name("Peñaflor") || Commune.create(:id => 13605, :name => 'Peñaflor', :region_id => 13))
aux << (Commune.find_by_name("Valdivia") || Commune.create(:id => 14101, :name => 'Valdivia', :region_id => 14))
aux << (Commune.find_by_name("Corral") || Commune.create(:id => 14102, :name => 'Corral', :region_id => 14))
aux << (Commune.find_by_name("Lanco") || Commune.create(:id => 14103, :name => 'Lanco', :region_id => 14))
aux << (Commune.find_by_name("Los Lagos") || Commune.create(:id => 14104, :name => 'Los Lagos', :region_id => 14))
aux << (Commune.find_by_name("Máfil") || Commune.create(:id => 14105, :name => 'Máfil', :region_id => 14))
aux << (Commune.find_by_name("Mariquina") || Commune.create(:id => 14106, :name => 'Mariquina', :region_id => 14))
aux << (Commune.find_by_name("Paillaco") || Commune.create(:id => 14107, :name => 'Paillaco', :region_id => 14))
aux << (Commune.find_by_name("Panguipulli") || Commune.create(:id => 14108, :name => 'Panguipulli', :region_id => 14))
aux << (Commune.find_by_name("La Unión") || Commune.create(:id => 14201, :name => 'La Unión', :region_id => 14))
aux << (Commune.find_by_name("Futrono") || Commune.create(:id => 14202, :name => 'Futrono', :region_id => 14))
aux << (Commune.find_by_name("Lago Ranco") || Commune.create(:id => 14203, :name => 'Lago Ranco', :region_id => 14))
aux << (Commune.find_by_name("Río Bueno") || Commune.create(:id => 14204, :name => 'Río Bueno', :region_id => 14))
aux << (Commune.find_by_name("Arica") || Commune.create(:id => 15101, :name => 'Arica', :region_id => 15))
aux << (Commune.find_by_name("Camarones") || Commune.create(:id => 15102, :name => 'Camarones', :region_id => 15))
aux << (Commune.find_by_name("Putre") || Commune.create(:id => 15201, :name => 'Putre', :region_id => 15))
aux << (Commune.find_by_name("General Lagos") || Commune.create(:id => 15202, :name => 'General Lagos', :region_id => 15))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Trading Houses:"
aux = []
aux << TradingHouse.find_or_create_by_name("Falabella")
aux << TradingHouse.find_or_create_by_name("Paris")
aux << TradingHouse.find_or_create_by_name("Ripley")
aux.each { |x| puts x.name}
puts "\n"

puts "--> Budget Distribution Types:"
aux = []
aux << BudgetDistributionType.find_or_create_by_name("Prorrateo según cantidad de invitados")
aux << BudgetDistributionType.find_or_create_by_name("Equitativo (25% cada uno)")
aux.each { |x| puts x.name}
puts "\n"

puts "--> Dress Types:"
aux = []
aux << (DressType.find_by_name("ajuar") || DressType.create(:name => 'ajuar', :description => "Ajuar para la novia"))
aux << (DressType.find_by_name("vestidos-fiesta") || DressType.create(:name => 'vestidos-fiesta', :description => "Vestidos para la fiesta"))
aux << (DressType.find_by_name("zapatos") || DressType.create(:name => 'zapatos', :description => "Zapatos"))

aux << (DressType.find_by_name("accesorios-aros") || DressType.create(:name => 'accesorios-aros', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-anillos") || DressType.create(:name => 'accesorios-anillos', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-collares") || DressType.create(:name => 'accesorios-collares', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-pulseras") || DressType.create(:name => 'accesorios-pulseras', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-carteras") || DressType.create(:name => 'accesorios-carteras', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-sombreros") || DressType.create(:name => 'accesorios-sombreros', :description => "Accesorios para fiesta"))
aux << (DressType.find_by_name("accesorios-carcasas") || DressType.create(:name => 'accesorios-carcasas', :description => "Carcasas para celulares"))

aux << (DressType.find_by_name("ropa-de-mujer-tops-poleras") || DressType.create(:name => 'ropa-de-mujer-tops-poleras', :description => "Poleras mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-tops-blusas") || DressType.create(:name => 'ropa-de-mujer-tops-blusas', :description => "Blusas mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-pantalones-tela") || DressType.create(:name => 'ropa-de-mujer-pantalones-tela', :description => "Pantalones mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-pantalones-jeans") || DressType.create(:name => 'ropa-de-mujer-pantalones-jeans', :description => "Jeans mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-pantalones-leggins") || DressType.create(:name => 'ropa-de-mujer-pantalones-leggins', :description => "Leggins mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-pantalones-panties") || DressType.create(:name => 'ropa-de-mujer-pantalones-panties', :description => "Panties mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-shorts") || DressType.create(:name => 'ropa-de-mujer-shorts', :description => "Shorts mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-polleras") || DressType.create(:name => 'ropa-de-mujer-polleras', :description => "Shorts mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-abrigados-chalecos") || DressType.create(:name => 'ropa-de-mujer-abrigados-chalecos', :description => "Chalecos mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-abrigados-polerones") || DressType.create(:name => 'ropa-de-mujer-abrigados-polerones', :description => "Polerones mujer"))
aux << (DressType.find_by_name("ropa-de-mujer-chaquetas") || DressType.create(:name => 'ropa-de-mujer-chaquetas', :description => "Chaquetas mujer"))

aux << (DressType.find_by_name("ropa-deportiva") || DressType.create(:name => 'ropa-deportiva', :description => "Ropa deportiva general"))

aux.each { |x| puts x.name}
puts "\n"

puts "--> View Count Types:"
aux = []
aux << (ViewCountType.find_by_name("Presentacion") || ViewCountType.create(:name => 'Presentacion', :description => "Cuando las personas revisan la presentación del proveedor"))
aux << (ViewCountType.find_by_name("Contacto") || ViewCountType.create(:name => 'Contacto', :description => "Cuando las personas piden el contacto del proveedor"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Slider Image Types:"
aux = []
aux << (SliderImageType.find_by_name("Inicio") || SliderImageType.create(:name => 'Inicio', :description => "Se muestra en la página de inicio"))
aux << (SliderImageType.find_by_name("Matri-Revista") || SliderImageType.create(:name => 'Matri-revista', :description => "Se muestra en el inicio de la Matri-Revista"))
aux << (SliderImageType.find_by_name("Matri-packs") || SliderImageType.create(:name => 'Matri-packs', :description => "Se muestra en el inicio de Casonas Matriclick"))
aux << (SliderImageType.find_by_name("Lunas de Miel") || SliderImageType.create(:name => 'Lunas de Miel', :description => "Se muestra en el inicio de Lunas de Miel"))
aux << (SliderImageType.find_by_name("Tu-Casa") || SliderImageType.create(:name => 'Tu-Casa', :description => "Se muestra en el inicio de Tu-Casa"))
aux << (SliderImageType.find_by_name("El Bazar") || SliderImageType.create(:name => 'El Bazar', :description => "Se muestra en el inicio de El Bazar Blog"))
aux << (SliderImageType.find_by_name("Viajes") || SliderImageType.create(:name => 'Viajes', :description => "Se muestra en el inicio de Viajes"))
aux << (SliderImageType.find_by_name("Aguclick") || SliderImageType.create(:name => 'Aguclick', :description => "Se muestra en el inicio de Aguclick"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Contract Types:"
aux = []
aux << (ContractType.find_by_name("Fijo") || ContractType.create(:name => 'Fijo', :description => "Contrato fijo"))
aux << (ContractType.find_by_name("Mixto") || ContractType.create(:name => 'Mixto', :description => "Contrato mixto"))
aux << (ContractType.find_by_name("Variable") || ContractType.create(:name => 'Variable', :description => "Contrato variable"))
aux << (ContractType.find_by_name("Especial") || ContractType.create(:name => 'Especial', :description => "Contrato especial"))
aux << (ContractType.find_by_name("GiftCard") || ContractType.create(:name => 'GiftCard', :description => "Contrato GiftCard"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Colors:"
aux = []
aux << (Color.find_by_name("Azul") || Color.create(:name => 'Azul', :description => "Color azul"))
aux << (Color.find_by_name("Verde") || Color.create(:name => 'Verde', :description => "Color verde"))
aux << (Color.find_by_name("Amarillo") || Color.create(:name => 'Amarillo', :description => "Color amarillo"))
aux << (Color.find_by_name("Blanco") || Color.create(:name => 'Blanco', :description => "Color blanco"))
aux << (Color.find_by_name("Negro") || Color.create(:name => 'Negro', :description => "Color negro"))
aux << (Color.find_by_name("Rojo") || Color.create(:name => 'Rojo', :description => "Color rojo"))
aux << (Color.find_by_name("Coral") || Color.create(:name => 'Coral', :description => "Color coral"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Contract State:"
aux = []
aux << (ContractState.find_by_name("Activo") || ContractState.create(:name => 'Activo', :description => "Contracto activo"))
aux << (ContractState.find_by_name("Moroso") || ContractState.create(:name => 'Moroso', :description => "Contrato moroso"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Supplier Account Type:"
aux = []
aux << (SupplierAccountType.find_by_name("Regular") || SupplierAccountType.create(:name => 'Regular', :description => "Proveedor regular"))
aux << (SupplierAccountType.find_by_name("Facebook") || SupplierAccountType.create(:name => 'Facebook', :description => "Tienda que opera exclusivamente por Facebook"))
aux << (SupplierAccountType.find_by_name("Matriclick") || SupplierAccountType.create(:name => 'Matriclick', :description => "Matriclick es dueño de la tienda"))
aux << (SupplierAccountType.find_by_name("Vestidos de Novia Usados") || SupplierAccountType.create(:name => 'Vestidos de Novia Usados', :description => "Vestidos de novia o de fiestas de personas naturales, cada vestido tiene un contacto distinto"))
aux << (SupplierAccountType.find_by_name("Vestidos Boutique") || SupplierAccountType.create(:name => 'Vestidos Boutique', :description => "Tienda catalogada por Matriclick como Boutique"))
aux << (SupplierAccountType.find_by_name("Ropa de Bebe") || SupplierAccountType.create(:name => 'Ropa de Bebe', :description => "Tiendas que ofrecen ropa de bebe"))
aux << (SupplierAccountType.find_by_name("Accesorios") || SupplierAccountType.create(:name => 'Accesorios', :description => "Tiendas que ofrecen accesorios para fiestas"))
aux << (SupplierAccountType.find_by_name("Zapatos") || SupplierAccountType.create(:name => 'Zapatos', :description => "Tiendas que ofrecen zapatos"))
aux << (SupplierAccountType.find_by_name("Tu Casa") || SupplierAccountType.create(:name => 'Tu Casa', :description => "Tiendas que ofrecen productos en Tu-Casa"))
aux << (SupplierAccountType.find_by_name("Ropa de Mujer") || SupplierAccountType.create(:name => 'Ropa de Mujer', :description => "Tiendas que ofrecen productos de Ropa de Mujer"))
aux << (SupplierAccountType.find_by_name("Viajes") || SupplierAccountType.create(:name => 'Viajes', :description => "Proveedores para modelar las ofertas de viajes"))
aux.each { |x| puts x.name}
puts "\n"

puts "--> Countries:"
aux = []
aux << (Country.find_by_name("Chile") || Country.create(:name => 'Chile', :url_path => 'chile'))
aux << (Country.find_by_name("Colombia") || Country.create(:name => 'Colombia', :url_path => 'colombia'))
aux << (Country.find_by_name("Perú") || Country.create(:name => 'Perú', :url_path => 'peru'))
aux << (Country.find_by_name("Argentina") || Country.create(:name => 'Argentina', :url_path => 'argentina'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> ChallengeActivityType:"
aux = []
aux << (ChallengeActivityType.find_by_name("Llamada") || ChallengeActivityType.create(:name => 'Llamada'))
aux << (ChallengeActivityType.find_by_name("Reunión") || ChallengeActivityType.create(:name => 'Reunión'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> WebpageContactState:"
aux = []
aux << (WebpageContactState.find_by_status("Pendiente") || WebpageContactState.create(:status => 'Pendiente'))
aux << (WebpageContactState.find_by_status("Cerrado") || WebpageContactState.create(:status => 'Cerrado'))
aux.each { |x| puts x.status}
puts "\n"

puts "--> Privilege:"
aux = []
aux << (Privilege.find_by_name("Salestool") || Privilege.create(:name => 'Salestool', :description => 'Puede administrar Matri-salestool'))
aux << (Privilege.find_by_name("Contactos") || Privilege.create(:name => 'Contactos', :description => 'Puede administrar los contactos y feedback que se hagan en la página'))
aux << (Privilege.find_by_name("Vestidos") || Privilege.create(:name => 'Vestidos', :description => 'Puede administrar los vestidos de novia y fiesta'))
aux << (Privilege.find_by_name("Proveedores") || Privilege.create(:name => 'Proveedores', :description => 'Puede administrar las cuentas de los proveedores'))
aux << (Privilege.find_by_name("Webpage") || Privilege.create(:name => 'Webpage', :description => 'Puede administrar la página agregando reviews, posts, imágenes, etc.'))
aux << (Privilege.find_by_name("Matriclickers") || Privilege.create(:name => 'Matriclickers', :description => 'Puede administrar Matriclickers'))
aux << (Privilege.find_by_name("Reportes") || Privilege.create(:name => 'Reportes', :description => 'Puede revisar los reportes generales'))
aux << (Privilege.find_by_name("Mensajes") || Privilege.create(:name => 'Mensajes', :description => 'Puede revisar los mensajes que realizaron los novios'))
aux << (Privilege.find_by_name("Finanzas") || Privilege.create(:name => 'Finanzas', :description => 'Puede revisar los reportes financieros, crear facturas y editarlas'))
aux << (Privilege.find_by_name("Leads") || Privilege.create(:name => 'Leads', :description => 'Puede editar el propietarios de los leads'))
aux << (Privilege.find_by_name("Tecnologia") || Privilege.create(:name => 'Tecnologia', :description => 'Puede editar leads, challenges y challenge_activities'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> DressStatus:"
aux = []
aux << (DressStatus.find_by_name("Disponible") || DressStatus.create(:name => 'Disponible', :description => 'Queda stock y está live en la página'))
aux << (DressStatus.find_by_name("Oculto") || DressStatus.create(:name => 'Oculto', :description => 'Queda stock pero no aparece en la página'))
aux << (DressStatus.find_by_name("Vendido") || DressStatus.create(:name => 'Vendido', :description => 'No queda stock y aparece en la página'))
aux << (DressStatus.find_by_name("Vendido y Oculto") || DressStatus.create(:name => 'Vendido y Oculto', :description => 'No queda stock y no aparece en la página'))
aux << (DressStatus.find_by_name("Admin-Test") || DressStatus.create(:name => 'Admin-Test', :description => 'Estado para Admins, para probar problemas con pagos'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> MatriclickerStatus:"
aux = []
aux << (MatriclickerStatus.find_by_name("Activo") || MatriclickerStatus.create(:name => 'Activo', :description => 'Aparece en los reportes'))
aux << (MatriclickerStatus.find_by_name("Oculto") || MatriclickerStatus.create(:name => 'Oculto', :description => 'No aparece en los reportes'))
aux << (MatriclickerStatus.find_by_name("Inactivo") || MatriclickerStatus.create(:name => 'Inactivo', :description => 'No aparece en el reporte y ya no trabaja en Matriclick'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> InvoiceMonth"
aux = []
current_date = DateTime.now - 2.months
final_date = current_date + 24.months

while current_date < final_date do
  aux << (InvoiceMonth.where('month = ? and year = ?', current_date.month, current_date.year).first || InvoiceMonth.create(:month => current_date.month, :year => current_date.year))  
  current_date = current_date + 1.months
end
aux.each { |x| puts(x.month.to_s+" "+x.year.to_s) }
puts "\n"

puts "--> GiftCardStatus:"
aux = []
aux << (GiftCardStatus.find_by_name("Activa") || GiftCardStatus.create(:name => 'Activa', :description => 'Gift Card Activa que se puede comprar'))
aux << (GiftCardStatus.find_by_name("Agotada") || GiftCardStatus.create(:name => 'Agotada', :description => 'Gift Card Agotada que no se puede comprar'))
aux << (GiftCardStatus.find_by_name("Inactiva") || GiftCardStatus.create(:name => 'Inactiva', :description => 'Gift Card Inactiva que no se puede comprar y no está agotada'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> SubscriberPreferences:"
aux = []
aux << (SubscriberPreference.find_by_name("Novios") || SubscriberPreference.create(:name => 'Novios', :description => 'Información y descuentoes especiales para los novios'))
aux << (SubscriberPreference.find_by_name("El Bazar") || SubscriberPreference.create(:name => 'El Bazar', :description => 'Vestidos, zapatos, accesorios y muchas cosas más de vestuario femenino'))
aux << (SubscriberPreference.find_by_name("Tu Casa") || SubscriberPreference.create(:name => 'Tu Casa', :description => 'Lo que necesitas de decoración y vivienda para armar tu hogar con estilo'))
aux << (SubscriberPreference.find_by_name("Bebe") || SubscriberPreference.create(:name => 'Bebe', :description => 'Ropa especialmente pensada para él/ella, recibe ideas y tips para las distintas etapas'))
aux << (SubscriberPreference.find_by_name("Viajes") || SubscriberPreference.create(:name => 'Viajes', :description => 'Matriclick Viajes te presentará distintos destinos y oportunidades únicas para tus vacaciones'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> RefundReasons:"
aux = []
aux << (RefundReason.find_by_name("Producto no calza con la descripción") || RefundReason.create(:name => 'Producto no calza con la descripción', :description => 'El producto que enviamos no calza con la descripción que aparece en la página'))
aux << (RefundReason.find_by_name("Producto con fallas") || RefundReason.create(:name => 'Producto con fallas', :description => 'El producto que enviamos venía con fallas: estaba roto o tenía algún defecto'))
aux << (RefundReason.find_by_name("Me arrepentí") || RefundReason.create(:name => 'Me arrepentí', :description => 'El producto que enviamos estaba en perfectas condiciones pero ya no lo quiero'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> DeliveryMethod:"
aux = []
aux << (DeliveryMethod.find_by_name("Normal") || DeliveryMethod.create(:name => 'Normal', :price => 0, :description => 'Desde 4 a 8 días hábiles para que tu compra esté en el lugar deseado'))
aux << (DeliveryMethod.find_by_name("Express") || DeliveryMethod.create(:name => 'Express', :price => 3000, :description => 'Desde 1 a 2 días hábiles para que tu compra esté en el lugar deseado'))
aux.each { |x| puts x.name}
puts "\n"

puts "--> ShoeSize:"
aux = []
aux << (ShoeSize.find_by_size_cl(35) || ShoeSize.create(:size_cl => 35, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(36) || ShoeSize.create(:size_cl => 36, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(37) || ShoeSize.create(:size_cl => 37, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(38) || ShoeSize.create(:size_cl => 38, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(39) || ShoeSize.create(:size_cl => 39, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(40) || ShoeSize.create(:size_cl => 40, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(41) || ShoeSize.create(:size_cl => 41, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(42) || ShoeSize.create(:size_cl => 42, :size_us => 0))
aux << (ShoeSize.find_by_size_cl(43) || ShoeSize.create(:size_cl => 43, :size_us => 0))
aux.each { |x| puts x.size_cl }
puts "\n"

puts "--> TagType:"
aux = []
aux << (TagType.find_by_name("Estilo Ropa") || TagType.create(:name => 'Estilo Ropa', :description => ''))
aux.each { |x| puts x.name }
puts "\n"

puts "--> Tag:"
aux = []
aux << (Tag.find_by_name("Formal") || Tag.create(:name => 'Formal', :image_name => 'formal.jpg', :tag_type_id => 1, :description => ''))
aux << (Tag.find_by_name("Hippie") || Tag.create(:name => 'Hippie', :image_name => 'hippie.jpg', :tag_type_id => 1, :description => ''))
aux << (Tag.find_by_name("Rockero") || Tag.create(:name => 'Rockero', :image_name => 'rockero.jpg', :tag_type_id => 1, :description => ''))
aux.each { |x| puts x.name }
puts "\n"