import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StoryPart {
  final String id;
  final String actNumber;
  final String title;
  final String fullTitle;
  final String summary;
  final String location;
  final String estimatedReadTime;
  final IconData icon;
  final Color badgeColor;
  final List<String> paragraphs;
  final String highlightQuote;
  final List<String> keyCharacters;

  const StoryPart({
    required this.id,
    required this.actNumber,
    required this.title,
    required this.fullTitle,
    required this.summary,
    required this.location,
    required this.estimatedReadTime,
    required this.icon,
    required this.badgeColor,
    required this.paragraphs,
    required this.highlightQuote,
    required this.keyCharacters,
  });
}

class StoryData {
  static const String mainArcTitle = 'El Llamado a la Cocina';
  static const String sagaTitle = 'La Odisea del Pan de Plátano';

  static const List<StoryPart> parts = [
    StoryPart(
      id: 'prologo',
      actNumber: 'Prólogo',
      title: 'El Decreto del Viejo Horno',
      fullTitle: 'Prólogo: El Decreto del Viejo Horno',
      summary:
          'En el puerto de San Blas, Don Lupe lanza un ultimátum: quien elabore el pan de plátano definitivo ganará la codiciada pala de oro del horno de piedra.',
      location: 'Puerto de San Blas • Panadería de Don Lupe',
      estimatedReadTime: '2 min de lectura',
      icon: Icons.fireplace_rounded,
      badgeColor: AppColors.primaryYellow,
      keyCharacters: ['Don Lupe', 'Ulises', 'Madame Circe'],
      highlightQuote:
          '«Aquel que logre crear el pan de plátano definitivo y llevarlo a tiempo a la mesa de jueces ganará la custodia de la pala de oro del horno de piedra.»\n— Don Lupe',
      paragraphs: [
        'En el puerto de San Blas, donde el aire huele a salitre, manglar y humedad espesa, la panadería rústica de Don Lupe sostiene una reputación legendaria. Sin embargo, los tiempos modernos no perdonan: las grandes cadenas hoteleras y las franquicias industriales amenazan con devorar la tradición local. Don Lupe, agotado tras décadas frente al fuego, reúne a su personal con un ultimátum que sacude el taller: aquel que logre crear el pan de plátano definitivo y llevarlo a tiempo a la mesa de jueces del Festival Gastronómico de la Riviera Nayarit ganará el codiciado título de Empleado del Mes, el ascenso a jefe de cocina y la custodia de la pala de oro del horno de piedra.',
        'Ulises, un joven panadero local cuya destreza con las masas solo es igualada por su terquedad, asume el desafío como un mandato del destino. Pero hornear una pieza legendaria no admite atajos de supermercado. Requiere los frutos más selectos de la costa, azúcar pura de caña, canela en rama y la harina perfecta. Mientras ata su delantal gastado, una silueta elegante y burlona se cruza en su camino: Madame Circe, una chef de alta cocina corporativa contratada por un consorcio rival. Armada con costosas batidoras cromadas y un desprecio absoluto por las recetas tradicionales, Circe le deja una advertencia clara: la costa no tiene espacio para recetas humildes. La carrera por la gloria culinaria acaba de comenzar.',
      ],
    ),
    StoryPart(
      id: 'acto_1',
      actNumber: 'Acto I',
      title: 'La Cueva del Mercado y el Fruto Prohibido',
      fullTitle: 'Acto I: La Cueva del Mercado y el Fruto Prohibido',
      summary:
          'Ulises escala balanzas y toldos en el mercado esquivando los sabotajes de Circe para arrebatar los plátanos machos reales custodiados por Polifemo.',
      location: 'Mercado Municipal de San Blas',
      estimatedReadTime: '3 min de lectura',
      icon: Icons.storefront_rounded,
      badgeColor: AppColors.mangroveGreen,
      keyCharacters: ['Ulises', 'Polifemo', 'Madame Circe'],
      highlightQuote:
          '«Con reflejos impecables y paciencia de artesano, Ulises aprovecha el vaivén de una soga, burla a Polifemo con un estallido de harina y arranca el racimo dorado.»',
      paragraphs: [
        'El amanecer revienta en el Mercado Municipal de San Blas. El bullicio es ensordecedor: gritos de pregoneros, lonas coloradas que crujen con el viento y laberintos formados por huacales de madera, costales de especias y cajas de verdura apiladas de forma precaria hacia el techo. Ulises sabe que los ingredientes base no bastan; en lo más alto de la nave central, donde la luz del tragaluz apenas alumbra, cuelgan los míticos plátanos machos reales, resguardados por Polifemo, un estibador descomunal de gesto adusto que jamás regala un gramo de su mercancía.',
        'Para alcanzar la cima, Ulises debe iniciar una vertiginosa escalada vertical. Salta sobre balanzas colgantes que oscilan con violencia, rebota sobre toldos de plástico templado y esquiva sacos de cebollas que caen sin previo aviso. La ascensión se torna traicionera cuando Madame Circe aparece en las vigas superiores. Decidida a frenarlo, la chef rival arroja cáscaras resbaladizas y cajas vacías, burlándose desde la penumbra mientras suelta carcajadas que retumban en el mercado. Con reflejos impecables y paciencia de artesano, Ulises aprovecha el vaivén de una soga de carga, burla el campo visual del corpulento Polifemo con un costal de harina que estalla en una nube blanca, y arranca el racimo dorado de plátano macho justo antes de que Circe escape en su camioneta. Con la cosecha dorada y las especias en su morral, el panadero emprende la retirada hacia el taller.',
      ],
    ),
    StoryPart(
      id: 'acto_2',
      actNumber: 'Acto II',
      title: 'El Asedio a la Panadería de Piedra',
      fullTitle: 'Acto II: El Asedio a la Panadería de Piedra',
      summary:
          'El aroma dulce de la masa desata un asedio al horno. Ulises defiende las brasas con rodillo, jarabe espeso y ventiladores ante plagas e infiltrados.',
      location: 'Patio Trasero • Horno Tradicional de Adobe',
      estimatedReadTime: '3 min de lectura',
      icon: Icons.outdoor_grill_rounded,
      badgeColor: AppColors.darkBrown,
      keyCharacters: ['Ulises', 'Saboteadores de Circe', 'Cocodrilos del Canal'],
      highlightQuote:
          '«Ulises no puede abandonar su puesto frente a la pala. Ventiladores oxidados, jarabe espeso y golpes de rodillo defienden la piedra ardiente minuto a minuto.»',
      paragraphs: [
        'De vuelta en el barrio, el sol abrasador del mediodía da paso a una atmósfera pesada y sofocante. En el patio trasero, el horno de barro y adobe ruge a temperatura viva. Ulises tritura los plátanos maduros, añade la canela recién molida y bate la mezcla con una cuchara de madera pesada hasta conseguir una masa densa, brillante y aromática. Pero en la costa, el perfume del plátano cocinándose con manteca y azúcar es un llamado irresistible que desata el caos.',
        'Al caer la tarde, la cocina se convierte en una fortaleza bajo asedio. Alertados por el olor y enviados por la competencia para sabotear el platillo, hordas de enemigos se abalanzan sobre el horno. Desde las grietas de la bodega irrumpen ratas hambrientas; por el aire descienden densas nubes de jejenes voraces capaces de arruinar la textura de la mezcla en segundos; y desde el canal contiguo se arrastran cocodrilos desorientados que avanzan derribando mesas de trabajo. Para colmo, ayudantes de cocina de Madame Circe intentan infiltrarse portando cubos de agua para apagar las brasas.',
        'Ulises no puede abandonar su puesto frente a la pala. Activando ventiladores oxidados para dispersar a los enjambres voladores, derramando jarabe espeso para frenar a las alimañas y golpeando con su rodillo de madera a cualquier intruso que toque la piedra ardiente, el panadero resiste el asalto minuto a minuto. El reloj corre implacable mientras el pan sube y adquiere su corteza dorada perfecta. Cuando el vapor dulce confirma que la cocción ha concluido, Ulises retira la charola intacta, la acomoda en una canasta de mimbre térmicamente sellada y mira hacia el horizonte: la feria ya ha comenzado al otro lado de la bahía.',
      ],
    ),
    StoryPart(
      id: 'acto_3',
      actNumber: 'Acto III',
      title: 'Carrera Desesperada por los Manglares de La Tovara',
      fullTitle: 'Acto III: Carrera Desesperada por los Manglares de La Tovara',
      summary:
          'Con la carretera inundada, Ulises corre sobre raíces y lodo esquivando cocodrilos para entregar el pan aún humeante a los jueces de la Riviera.',
      location: 'Manglares de La Tovara • Riviera Nayarit',
      estimatedReadTime: '3 min de lectura',
      icon: Icons.water_rounded,
      badgeColor: AppColors.mangroveGreen,
      keyCharacters: ['Ulises', 'Jueces del Festival', 'Don Lupe', 'Madame Circe'],
      highlightQuote:
          '«Al cortar la primera rebanada, el aroma a plátano caramelizado inunda la carpa entera. Don Lupe cuelga la medalla en el pecho de Ulises, coronando la odisea más dulce de la Riviera.»',
      paragraphs: [
        'El tiempo se agota. La carretera principal está bloqueada por la tormenta y el único camino hacia el recinto ferial cruza la espesura salvaje de los manglares de La Tovara. Con la canasta bien sujeta a su espalda y el pan aún humeante, Ulises emprende una carrera desenfrenada contra el cronómetro y la naturaleza salvaje.',
        'La travesía exige una sincronización perfecta. El panadero corre a toda velocidad sobre pasarelas de madera carcomida, troncos resbaladizos y raíces gigantescas que sobresalen del fango. En las aguas turbias, los cocodrilos abren sus mandíbulas en secuencias rítmicas, obligándolo a saltar con milimétrica precisión. Desde el dosel vegetal descienden ramas bajas cargadas de espinas que exigen deslizarse por el lodo sin soltar la preciada carga, mientras pelícanos y garzas costeras se lanzan en picada intentando arrebatar bocados del pan a través de la tela de mimbre. A lo lejos, el rugido de la tormenta amenaza con desbaratar los puentes colgantes, pero el impulso de Ulises no cede.',
        'Con los pulmones ardiendo y el delantal salpicado de barro y sudor, Ulises divisa las carpas iluminadas del festival gastronómico. En el estrado principal, los jueces observan con frialdad los panes prefabricados de Madame Circe y se preparan para dar por cerrado el registro. En el último segundo, Ulises cruza la línea de entrada barriéndose con la canasta en alto. Al cortar la primera rebanada, el aroma a plátano macho caramelizado, leña y canela inunda la carpa entera. Los jueces quedan desarmados ante la autenticidad del sabor costeño. Entre los aplausos del pueblo de San Blas y la mirada atónita de Circe, Don Lupe cuelga la medalla de Empleado del Mes en el pecho de Ulises, coronando su odisea como la leyenda más dulce de la Riviera.',
      ],
    ),
  ];

  static StoryPart? getPartById(String id) {
    try {
      return parts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static StoryPart? getNextPart(String currentId) {
    final idx = parts.indexWhere((p) => p.id == currentId);
    if (idx >= 0 && idx < parts.length - 1) {
      return parts[idx + 1];
    }
    return null;
  }

  static StoryPart? getPreviousPart(String currentId) {
    final idx = parts.indexWhere((p) => p.id == currentId);
    if (idx > 0) {
      return parts[idx - 1];
    }
    return null;
  }
}
