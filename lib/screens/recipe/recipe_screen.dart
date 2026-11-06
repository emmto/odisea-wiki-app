import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class RecipeScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const RecipeScreen({super.key, this.onBack});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // Lista de ingredientes con estado para el checklist interactivo
  final List<Map<String, dynamic>> _ingredients = [
    {
      'name': '4 plátanos maduros',
      'detail': 'De preferencia con pecas para mayor dulzor y consistencia',
      'checked': false,
      'icon': Icons.eco_rounded,
    },
    {
      'name': '1 y 1/2 taza de harina de trigo',
      'detail': 'Base de la masa tradicional',
      'checked': false,
      'icon': Icons.grain_rounded,
    },
    {
      'name': '50 g de mantequilla',
      'detail': 'A temperatura ambiente para acremar',
      'checked': false,
      'icon': Icons.bakery_dining_rounded,
    },
    {
      'name': '1 taza de azúcar morena',
      'detail': 'Aporta color caramelo y aroma tostado',
      'checked': false,
      'icon': Icons.cookie_outlined,
    },
    {
      'name': '4 cdas de crema ácida',
      'detail': 'El toque secreto costero para máxima esponjosidad y humedad',
      'checked': false,
      'icon': Icons.soup_kitchen_rounded,
    },
    {
      'name': '2 huevos',
      'detail': 'Frescos y a temperatura ambiente',
      'checked': false,
      'icon': Icons.egg_outlined,
    },
    {
      'name': '1 cda de Royal (polvo para hornear)',
      'detail': 'Para un crecimiento parejo',
      'checked': false,
      'icon': Icons.science_outlined,
    },
    {
      'name': '1 cdita de bicarbonato de sodio',
      'detail': 'Reactivo con la acidez del plátano y crema',
      'checked': false,
      'icon': Icons.bubble_chart_outlined,
    },
    {
      'name': '1 cdita de extracto de vainilla',
      'detail': 'Aroma tradicional de repostería',
      'checked': false,
      'icon': Icons.water_drop_outlined,
    },
    {
      'name': '2 cdas de almendras',
      'detail': 'Picadas en pedacitos para textura crujiente',
      'checked': false,
      'icon': Icons.spa_outlined,
    },
  ];

  int get _checkedCount => _ingredients.where((i) => i['checked'] == true).length;

  void _toggleAllIngredients(bool value) {
    setState(() {
      for (var item in _ingredients) {
        item['checked'] = value;
      }
    });
  }

  void _showRecipeLoreDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBrown, width: 2),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.darkBrown, width: 1.5),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: AppColors.darkBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Tradición de San Blas',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Joyel Gastronómico de Nayarit',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Aunque el pan de plátano es un platillo popular en todo el estado de Nayarit, en el Pueblo Mágico de San Blas es considerado un ícono de su cultura gastronómica.\n\nEste delicioso postre costero destaca por su sabor único y sus nutrientes, siendo una de las recetas más queridas de la región. Pocas recetas logran capturar la esencia y el sabor auténtico que este pan ofrece en cada bocado, convirtiéndolo en una verdadera joya culinaria de la zona.',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: AppColors.darkBrown.withValues(alpha: 0.85),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryYellow,
              foregroundColor: AppColors.darkBrown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.darkBrown, width: 1.5),
              ),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              '¡Entendido!',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // 1. TOP BAR PERSONALIZADA (Consistente con la app)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: topPadding + 10,
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              color: AppColors.topBarBeige,
              border: Border(
                bottom: BorderSide(color: AppColors.doughBeige, width: 1.5),
              ),
            ),
            child: SizedBox(
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Título centrado
                  Text(
                    'Receta Tradicional',
                    style: GoogleFonts.outfit(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  // Botón volver
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.darkBrown,
                        size: 24,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      tooltip: 'Volver',
                      onPressed: () {
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                  // Botón circular amarillo ⓘ de información
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _showRecipeLoreDialog,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.darkBrown, width: 1.8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkBrown.withValues(alpha: 0.12),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 19,
                            color: AppColors.darkBrown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL SCROLLABLE
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // HERO CARD CON ILUSTRACIÓN RUBBER HOSE DEL PAN DE PLÁTANO
                  _buildHeroImageCard(),

                  const SizedBox(height: 16),

                  // TARJETA DE ESTADÍSTICAS RÁPIDAS (Tiempo, Porciones, Horno, Origen)
                  _buildQuickStatsRow(),

                  const SizedBox(height: 20),

                  // SECCIÓN DE INGREDIENTES CON CHECKLIST
                  _buildIngredientsSection(),

                  const SizedBox(height: 24),

                  // SECCIÓN DE PREPARACIÓN PASO A PASO
                  _buildPreparationSection(),

                  const SizedBox(height: 24),

                  // CONSEJO SECRETO DEL MAESTRO DON LUPE
                  _buildDonLupeTipCard(),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BANNER ILUSTRADO CON ESTILO CARTOON
  Widget _buildHeroImageCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.15),
            offset: const Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/pan_platano_receta.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.doughBeige,
                    child: Center(
                      child: Icon(
                        Icons.bakery_dining_rounded,
                        size: 64,
                        color: AppColors.darkBrown.withValues(alpha: 0.4),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.darkBrown, width: 1.2),
                        ),
                        child: Text(
                          'PUEBLO MÁGICO',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkBrown,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'San Blas, Nayarit',
                        style: GoogleFonts.rubik(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mangroveGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pan de Plátano Típico de Nayarit',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkBrown,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'El auténtico sabor tradicional de la costa. Miga húmeda, aroma a plátano macho y cubierta de almendras doradas.',
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      color: AppColors.darkBrown.withValues(alpha: 0.75),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4 CHIPS / CARDS DE DATOS CLAVE
  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            icon: Icons.timer_outlined,
            title: 'Tiempo',
            value: '1:10 h',
            color: AppColors.primaryYellow,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatItem(
            icon: Icons.pie_chart_outline_rounded,
            title: 'Porciones',
            value: '6 piezas',
            color: AppColors.doughBeige,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatItem(
            icon: Icons.fireplace_rounded,
            title: 'Horno',
            value: '180° C',
            color: AppColors.topBarBeige,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBrown, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkBrown, width: 1.2),
            ),
            child: Icon(icon, size: 16, color: AppColors.darkBrown),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.rubik(
              fontSize: 11,
              color: AppColors.darkBrown.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  // SECCIÓN DE INGREDIENTES
  Widget _buildIngredientsSection() {
    final allChecked = _checkedCount == _ingredients.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.12),
            offset: const Offset(0, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.darkBrown, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.shopping_basket_rounded,
                      size: 18,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Ingredientes',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ],
              ),
              // Botón para marcar/desmarcar todos
              InkWell(
                onTap: () => _toggleAllIngredients(!allChecked),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    allChecked ? 'Desmarcar' : 'Marcar todos',
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mangroveGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Barra de progreso del checklist
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _ingredients.isEmpty ? 0 : _checkedCount / _ingredients.length,
              minHeight: 6,
              backgroundColor: AppColors.doughBeige,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.mangroveGreen),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_checkedCount de ${_ingredients.length} preparados',
                style: GoogleFonts.rubik(
                  fontSize: 11,
                  color: AppColors.darkBrown.withValues(alpha: 0.6),
                ),
              ),
              if (allChecked)
                Text(
                  '¡Listo para mezclar! ✨',
                  style: GoogleFonts.rubik(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mangroveGreen,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          const Divider(color: AppColors.doughBeige, thickness: 1.5),

          // Lista de ingredientes
          ListView.separated(
            itemCount: _ingredients.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.doughBeige,
              height: 12,
              thickness: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = _ingredients[index];
              final isChecked = item['checked'] as bool;

              return InkWell(
                onTap: () {
                  setState(() {
                    item['checked'] = !isChecked;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      // Checkbox custom con bordes retro
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isChecked ? AppColors.primaryYellow : AppColors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.darkBrown, width: 1.8),
                        ),
                        child: isChecked
                            ? const Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: AppColors.darkBrown,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isChecked
                                    ? AppColors.darkBrown.withValues(alpha: 0.45)
                                    : AppColors.darkBrown,
                                decoration: isChecked ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            Text(
                              item['detail'],
                              style: GoogleFonts.rubik(
                                fontSize: 11,
                                color: isChecked
                                    ? AppColors.darkBrown.withValues(alpha: 0.35)
                                    : AppColors.darkBrown.withValues(alpha: 0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // SECCIÓN DE PASOS DE PREPARACIÓN
  Widget _buildPreparationSection() {
    final steps = [
      {
        'step': 1,
        'title': 'Machacado & Batido Base',
        'desc':
            'Machaca los 4 plátanos maduros en un recipiente hondo. Para lograr una mejor consistencia y dulzor natural, elige plátanos bien maduros con pecas. Sin dejar de batir, agrega el azúcar morena, los huevos y la mantequilla, hasta lograr una mezcla homogénea y brillante.',
        'icon': Icons.blender_rounded,
      },
      {
        'step': 2,
        'title': 'Tamizado de Secos',
        'desc':
            'En un molde o tazón independiente, mezcla la harina de trigo, la cucharada de Royal (polvo para hornear) y la cucharadita de bicarbonato de sodio.',
        'icon': Icons.grain_rounded,
      },
      {
        'step': 3,
        'title': 'Integración & Toque Costero',
        'desc':
            'Agrega los ingredientes secos a toda la mezcla, bate bien y lentamente suma la crema ácida. Al tener una masa completa, cremosa y sin grumos, agrega la vainilla y las almendras en pedacitos.',
        'icon': Icons.auto_awesome_rounded,
      },
      {
        'step': 4,
        'title': 'Horneado a 180°',
        'desc':
            'En un molde limpio para hornear agrega un poco de mantequilla y enharínalo ligeramente. Vierte la masa y ponlo al horno a 180°C. Deja que esponje dorado y revisa con un palillo que no queden residuos de masa.',
        'icon': Icons.fireplace_rounded,
      },
      {
        'step': 5,
        'title': 'Enfriar & Servir',
        'desc':
            'Deja enfriar sobre una rejilla para que se asienten los sabores y la humedad del plátano. Corta en rebanadas gruesas y ¡sirve el tradicional manjar de San Blas!',
        'icon': Icons.done_all_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.mangroveGreen,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.darkBrown, width: 1.5),
              ),
              child: const Icon(
                Icons.restaurant_menu_rounded,
                size: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Preparación Paso a Paso',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        ListView.separated(
          itemCount: steps.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final s = steps[index];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBrown, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBrown.withValues(alpha: 0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge circular numerado estilo Rubber Hose
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.darkBrown, width: 1.8),
                    ),
                    child: Center(
                      child: Text(
                        '${s['step']}',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['title'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s['desc'] as String,
                          style: GoogleFonts.rubik(
                            fontSize: 13,
                            color: AppColors.darkBrown.withValues(alpha: 0.8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // TARJETA DE CONSEJO DEL MAESTRO DON LUPE
  Widget _buildDonLupeTipCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.topBarBeige,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mangroveGreen, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBrown.withValues(alpha: 0.1),
            offset: const Offset(0, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.mangroveGreen,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.darkBrown, width: 1.5),
            ),
            child: const Icon(
              Icons.lightbulb_rounded,
              color: AppColors.primaryYellow,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'El Secreto de Don Lupe',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '«El secreto de nuestro pan en San Blas es no tener prisa con la crema ácida ni con el horno. Si lo horneas en horno de leña, mantén la brasa pareja para que la costra de almendra quede dorada sin quemarse.»',
                  style: GoogleFonts.rubik(
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    color: AppColors.darkBrown.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
