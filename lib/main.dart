import 'package:flutter/material.dart';

void main() => runApp(const Reserva7App());

const green = Color(0xFF0B3D36);
const cream = Color(0xFFF6F5F0);
const mint = Color(0xFFE2ECE7);
const gold = Color(0xFFC7A66A);

class Reserva7App extends StatelessWidget {
  const Reserva7App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Reserva7',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(seedColor: green),
      fontFamily: 'Arial',
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: green)),
      ),
    ),
    home: const SplashPage(),
  );
}

void push(BuildContext c, Widget page) => Navigator.push(c, MaterialPageRoute(builder: (_) => page));

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
    });
  }
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: green,
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 88, height: 88, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(28)), child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 44)),
      const SizedBox(height: 22),
      const Text('RESERVA7', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 8),
      const Text('Reserve. Experience. Enjoy.', style: TextStyle(color: Colors.white60)),
    ])),
  );
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override State<OnboardingPage> createState() => _OnboardingPageState();
}
class _OnboardingPageState extends State<OnboardingPage> {
  int page = 0;
  final slides = const [
    ('Descubra lugares especiais', 'Restaurantes, mesas e experiências selecionadas para você.', Icons.explore_rounded),
    ('Reserve em poucos segundos', 'Veja horários disponíveis e confirme sua experiência.', Icons.event_available_rounded),
    ('Tudo em um só lugar', 'Acompanhe reservas, favoritos e novas experiências.', Icons.auto_awesome_rounded),
  ];
  void finish() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  @override Widget build(BuildContext context) {
    final s = slides[page];
    return Scaffold(body: SafeArea(child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      child: Column(children: [
        Align(alignment: Alignment.centerRight, child: TextButton(onPressed: finish, child: const Text('Pular'))),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(height: 310, width: double.infinity, decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [mint, Color(0xFFD0DED8)]),
            borderRadius: BorderRadius.circular(36),
          ), child: Center(child: Icon(s.$3, size: 110, color: green))),
          const SizedBox(height: 36),
          Text(s.$1, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Text(s.$2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.45)),
        ])),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200), margin: const EdgeInsets.all(4), width: i == page ? 28 : 8, height: 8,
          decoration: BoxDecoration(color: i == page ? green : Colors.black12, borderRadius: BorderRadius.circular(8)),
        ))),
        const SizedBox(height: 20),
        _Button(label: page < 2 ? 'Continuar' : 'Começar', onTap: () {
          if (page < 2) setState(() => page++);
          else finish();
        }),
      ]),
    )));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController(), password = TextEditingController();
  bool hidden = true;
  @override void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => _Auth(
    title: 'Bem-vindo de volta', subtitle: 'Entre para continuar sua experiência.',
    children: [
      _Field(email, 'E-mail', Icons.email_outlined, keyboard: TextInputType.emailAddress),
      const SizedBox(height: 13),
      _Field(password, 'Senha', Icons.lock_outline, obscure: hidden, suffix: IconButton(onPressed: () => setState(() => hidden = !hidden), icon: Icon(hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined))),
      Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => push(context, const RecoveryPage()), child: const Text('Esqueci minha senha'))),
      const SizedBox(height: 7),
      _Button(label: 'Entrar', onTap: () => push(context, const LocationPage())),
      const SizedBox(height: 12),
      _Outline(label: 'Criar minha conta', onTap: () => push(context, const RegisterPage())),
    ],
  );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final name=TextEditingController(), email=TextEditingController(), phone=TextEditingController(), pass=TextEditingController();
  bool hidden=true;
  @override void dispose(){name.dispose();email.dispose();phone.dispose();pass.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>_Auth(title:'Crie sua conta',subtitle:'Uma conta simples para guardar suas experiências.',children:[
    _Field(name,'Nome completo',Icons.person_outline),const SizedBox(height:13),
    _Field(email,'E-mail',Icons.email_outlined,keyboard:TextInputType.emailAddress),const SizedBox(height:13),
    _Field(phone,'Telefone',Icons.phone_outlined,keyboard:TextInputType.phone),const SizedBox(height:13),
    _Field(pass,'Senha',Icons.lock_outline,obscure:hidden,suffix:IconButton(onPressed:()=>setState(()=>hidden=!hidden),icon:Icon(hidden?Icons.visibility_outlined:Icons.visibility_off_outlined))),
    const SizedBox(height:24),_Button(label:'Continuar',onTap:()=>push(context,const VerifyPage(title:'Confirme seu cadastro'))),
  ]);
}

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});
  @override State<RecoveryPage> createState()=>_RecoveryPageState();
}
class _RecoveryPageState extends State<RecoveryPage>{
  final email=TextEditingController();
  @override void dispose(){email.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>_Auth(title:'Recuperar acesso',subtitle:'Digite seu e-mail e enviaremos um código de verificação.',children:[
    _Field(email,'E-mail',Icons.email_outlined,keyboard:TextInputType.emailAddress),
    const SizedBox(height:24),_Button(label:'Enviar código',onTap:()=>push(context,const VerifyPage(title:'Recuperar acesso'))),
  ]);
}

class VerifyPage extends StatefulWidget {
  final String title;
  const VerifyPage({super.key,this.title='Verifique seu acesso'});
  @override State<VerifyPage> createState()=>_VerifyPageState();
}
class _VerifyPageState extends State<VerifyPage>{
  final code=TextEditingController();
  @override void dispose(){code.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>_Auth(title:widget.title,subtitle:'Digite o código de 6 dígitos enviado para seu e-mail.',children:[
    _Field(code,'Código de verificação',Icons.verified_outlined,keyboard:TextInputType.number,maxLength:6),
    Center(child:TextButton(onPressed:(){},child:const Text('Reenviar código'))),
    _Button(label:'Verificar',onTap:()=>push(context,const NewPasswordPage())),
  ]);
}

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});
  @override State<NewPasswordPage> createState()=>_NewPasswordPageState();
}
class _NewPasswordPageState extends State<NewPasswordPage>{
  final a=TextEditingController(),b=TextEditingController(); bool hidden=true;
  @override void dispose(){a.dispose();b.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>_Auth(title:'Nova senha',subtitle:'Crie uma nova senha segura para sua conta.',children:[
    _Field(a,'Nova senha',Icons.lock_outline,obscure:hidden),const SizedBox(height:13),
    _Field(b,'Confirmar senha',Icons.lock_outline,obscure:hidden),
    const SizedBox(height:24),_Button(label:'Salvar nova senha',onTap:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const LocationPage()),(_)=>false)),
  ]);
}

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Padding(padding:const EdgeInsets.all(24),child:Column(children:[
    const Spacer(),
    Container(width:120,height:120,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(38)),child:const Icon(Icons.location_on_rounded,size:60,color:green)),
    const SizedBox(height:32),const Text('PERSONALIZE SUA EXPERIÊNCIA',style:TextStyle(color:gold,fontSize:11,fontWeight:FontWeight.w900,letterSpacing:2)),
    const SizedBox(height:10),const Text('Onde você está?',textAlign:TextAlign.center,style:TextStyle(fontSize:32,fontWeight:FontWeight.w900)),
    const SizedBox(height:14),const Text('Usaremos sua localização para mostrar experiências e disponibilidade perto de você.',textAlign:TextAlign.center,style:TextStyle(color:Colors.black54,fontSize:16,height:1.45)),
    const Spacer(),_Button(label:'Usar minha localização',onTap:()=>push(context,const CityPage())),TextButton(onPressed:()=>push(context,const CityPage()),child:const Text('Escolher cidade manualmente')),
  ])));
}

class CityPage extends StatelessWidget {
  const CityPage({super.key});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(backgroundColor:cream,elevation:0),body:ListView(padding:const EdgeInsets.all(24),children:[
    const Text('Escolha sua cidade',style:TextStyle(fontSize:31,fontWeight:FontWeight.w900)),
    const SizedBox(height:8),const Text('Começaremos por experiências disponíveis na região escolhida.',style:TextStyle(color:Colors.black54)),
    const SizedBox(height:25),
    _City('Madrid','España',Icons.location_city_rounded,context),_City('Barcelona','España',Icons.waves_rounded,context),_City('São Paulo','Brasil',Icons.apartment_rounded,context),
  ]));
}
Widget _City(String city,String country,IconData icon,BuildContext c)=>Container(margin:const EdgeInsets.only(bottom:11),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(20)),child:ListTile(
  contentPadding:const EdgeInsets.symmetric(horizontal:18,vertical:7),
  leading:Container(width:48,height:48,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(14)),child:Icon(icon,color:green)),
  title:Text(city,style:const TextStyle(fontWeight:FontWeight.w800)),subtitle:Text(country),trailing:const Icon(Icons.chevron_right_rounded),
  onTap:()=>Navigator.pushAndRemoveUntil(c,MaterialPageRoute(builder:(_)=>const HomePage()),(_)=>false),
));

class _Auth extends StatelessWidget {
  final String title,subtitle; final List<Widget> children;
  const _Auth({required this.title,required this.subtitle,required this.children});
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:SingleChildScrollView(padding:const EdgeInsets.fromLTRB(24,15,24,30),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    IconButton(alignment:Alignment.centerLeft,onPressed:()=>Navigator.pop(context),icon:const Icon(Icons.arrow_back_rounded)),
    const SizedBox(height:10),
    Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:green,borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.restaurant_rounded,color:Colors.white)),const SizedBox(width:12),const Text('RESERVA7',style:TextStyle(fontWeight:FontWeight.w900,letterSpacing:2))]),
    const SizedBox(height:42),Text(title,style:const TextStyle(fontSize:31,fontWeight:FontWeight.w900)),const SizedBox(height:10),Text(subtitle,style:const TextStyle(color:Colors.black54,fontSize:16,height:1.4)),const SizedBox(height:30),...children,
  ])));
}
class _Field extends StatelessWidget {
  final TextEditingController controller; final String label; final IconData icon; final bool obscure; final Widget? suffix; final TextInputType? keyboard; final int? maxLength;
  const _Field(this.controller,this.label,this.icon,{this.obscure=false,this.suffix,this.keyboard,this.maxLength});
  @override Widget build(BuildContext context)=>TextField(controller:controller,obscureText:obscure,keyboardType:keyboard,maxLength:maxLength,decoration:InputDecoration(labelText:label,prefixIcon:Icon(icon),suffixIcon:suffix,counterText:maxLength==null?null:'')); 
}
class _Button extends StatelessWidget {
  final String label; final VoidCallback onTap;
  const _Button({required this.label,required this.onTap});
  @override Widget build(BuildContext context)=>SizedBox(width:double.infinity,child:FilledButton(onPressed:onTap,style:FilledButton.styleFrom(backgroundColor:green,foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:17),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18))),child:Text(label,style:const TextStyle(fontWeight:FontWeight.w800))));
}
class _Outline extends StatelessWidget {
  final String label; final VoidCallback onTap;
  const _Outline({required this.label,required this.onTap});
  @override Widget build(BuildContext context)=>SizedBox(width:double.infinity,child:OutlinedButton(onPressed:onTap,style:OutlinedButton.styleFrom(padding:const EdgeInsets.symmetric(vertical:17),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18))),child:Text(label,style:const TextStyle(fontWeight:FontWeight.w700))));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage>{
  int tab=0;
  final items=const [
    ('Casa Alba','Mediterrâneo','Salamanca','€€€',Icons.restaurant_rounded),
    ('Brasa Madrid','Grelhados','Centro','€€',Icons.local_fire_department_rounded),
    ('Atelier 7','Contemporâneo','Chamberí','€€€',Icons.auto_awesome_rounded),
  ];
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(backgroundColor:cream,elevation:0,title:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('RESERVA7',style:TextStyle(fontSize:17,fontWeight:FontWeight.w900,letterSpacing:2)),
        Text(['Início','Explorar','Reservas','Perfil'][tab],style:const TextStyle(fontSize:11,color:Colors.black45)),
      ]),actions:[IconButton(onPressed:()=>push(context,const NotificationsPage()),icon:const Icon(Icons.notifications_none_rounded))]),
      body:IndexedStack(index:tab,children:[_home(),_explore(),_bookings(),_profile()]),
      bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(v)=>setState(()=>tab=v),destinations:const[
        NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home_rounded),label:'Início'),
        NavigationDestination(icon:Icon(Icons.search_outlined),selectedIcon:Icon(Icons.search_rounded),label:'Explorar'),
        NavigationDestination(icon:Icon(Icons.event_outlined),selectedIcon:Icon(Icons.event_rounded),label:'Reservas'),
        NavigationDestination(icon:Icon(Icons.person_outline_rounded),selectedIcon:Icon(Icons.person_rounded),label:'Perfil'),
      ]),
    );
  }
  Widget _home()=>ListView(padding:const EdgeInsets.fromLTRB(20,8,20,30),children:[
    const Text('Boa noite',style:TextStyle(color:Colors.black45)),const SizedBox(height:4),
    const Text('Onde você quer viver\numa experiência?',style:TextStyle(fontSize:31,fontWeight:FontWeight.w900,height:1.05)),
    const SizedBox(height:21),
    TextField(decoration:InputDecoration(hintText:'Restaurante, cozinha ou experiência',prefixIcon:const Icon(Icons.search_rounded),suffixIcon:IconButton(onPressed:()=>setState(()=>tab=1),icon:const Icon(Icons.tune_rounded)))),
    const SizedBox(height:24),Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('Categorias',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),TextButton(onPressed:()=>setState(()=>tab=1),child:const Text('Ver todas'))]),
    SizedBox(height:91,child:ListView(scrollDirection:Axis.horizontal,children:[
      _Cat(Icons.restaurant_rounded,'Restaurantes'),_Cat(Icons.local_fire_department_rounded,'Brasa'),_Cat(Icons.wine_bar_rounded,'Wine'),_Cat(Icons.cake_rounded,'Celebrar'),_Cat(Icons.auto_awesome_rounded,'Experiências'),
    ])),
    const SizedBox(height:18),const _Hero(),
    const SizedBox(height:25),Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('Para você',style:TextStyle(fontSize:21,fontWeight:FontWeight.w800)),TextButton(onPressed:()=>setState(()=>tab=1),child:const Text('Explorar'))]),
    ...items.map((e)=>_Card(data:e,onTap:()=>push(context,DetailPage(name:e.$1,type:e.$2,location:e.$3,price:e.$4,icon:e.$5)))),
  ]);
  Widget _explore()=>ListView(padding:const EdgeInsets.all(20),children:[
    const Text('Explore',style:TextStyle(fontSize:31,fontWeight:FontWeight.w900)),const SizedBox(height:6),const Text('Encontre o próximo lugar para viver algo especial.',style:TextStyle(color:Colors.black54)),
    const SizedBox(height:20),const TextField(decoration:InputDecoration(hintText:'Buscar por nome, cozinha...',prefixIcon:Icon(Icons.search_rounded))),
    const SizedBox(height:18),Wrap(spacing:8,runSpacing:8,children:['Todos','Mediterrâneo','Brasa','Wine','Contemporâneo'].map((x)=>Chip(label:Text(x))).toList()),
    const SizedBox(height:18),...items.map((e)=>_Card(data:e,onTap:()=>push(context,DetailPage(name:e.$1,type:e.$2,location:e.$3,price:e.$4,icon:e.$5)))),
  ]);
  Widget _bookings()=>ListView(padding:const EdgeInsets.all(20),children:[
    const _Empty(icon:Icons.event_available_rounded),const SizedBox(height:18),
    const Center(child:Text('Suas reservas aparecerão aqui',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800))),
    const SizedBox(height:7),const Center(child:Text('Escolha uma experiência e faça sua primeira reserva.',textAlign:TextAlign.center,style:TextStyle(color:Colors.black54))),
    const SizedBox(height:20),_Button(label:'Explorar experiências',onTap:()=>setState(()=>tab=1)),
  ]);
  Widget _profile()=>ListView(padding:const EdgeInsets.all(20),children:[
    Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:green,borderRadius:BorderRadius.circular(26)),child:const Row(children:[
      CircleAvatar(radius:30,backgroundColor:Colors.white24,child:Icon(Icons.person_rounded,color:Colors.white,size:30)),SizedBox(width:14),
      Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Minha conta',style:TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.w800)),Text('Perfil e preferências',style:TextStyle(color:Colors.white70))])
    ])),
    const SizedBox(height:18),
    ...[('Dados pessoais',Icons.person_outline_rounded),('Favoritos',Icons.favorite_border_rounded),('Localização',Icons.location_on_outlined),('Notificações',Icons.notifications_none_rounded),('Ajuda e suporte',Icons.help_outline_rounded),('Termos e privacidade',Icons.shield_outlined)].map((x)=>Container(margin:const EdgeInsets.only(bottom:10),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(18)),child:ListTile(leading:Icon(x.$2,color:green),title:Text(x.$1,style:const TextStyle(fontWeight:FontWeight.w700)),trailing:const Icon(Icons.chevron_right_rounded)))),
  ]);
}

class _Cat extends StatelessWidget {
  final IconData icon; final String label;
  const _Cat(this.icon,this.label);
  @override Widget build(BuildContext context)=>Container(width:82,margin:const EdgeInsets.only(right:10),child:Column(children:[
    Container(width:58,height:58,decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(18)),child:Icon(icon,color:green)),const SizedBox(height:7),Text(label,textAlign:TextAlign.center,style:const TextStyle(fontSize:11,fontWeight:FontWeight.w700))
  ]));
}
class _Hero extends StatelessWidget {
  const _Hero();
  @override Widget build(BuildContext context)=>Container(height:190,padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:green,borderRadius:BorderRadius.circular(28)),child:Stack(children:[
    const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('EXPERIÊNCIA DA SEMANA',style:TextStyle(color:gold,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:2)),Spacer(),Text('Uma mesa\nque vale a noite.',style:TextStyle(color:Colors.white,fontSize:27,fontWeight:FontWeight.w900,height:1.02)),SizedBox(height:8),Text('Lugares selecionados em Madrid.',style:TextStyle(color:Colors.white70))]),
    Positioned(right:4,bottom:18,child:Icon(Icons.restaurant_rounded,color:Colors.white24,size:78)),
  ]));
}
class _Card extends StatelessWidget {
  final (String,String,String,String,IconData) data; final VoidCallback onTap;
  const _Card({required this.data,required this.onTap});
  @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.only(bottom:12),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(23)),child:InkWell(borderRadius:BorderRadius.circular(23),onTap:onTap,child:Padding(padding:const EdgeInsets.all(13),child:Row(children:[
    Container(width:82,height:82,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(17)),child:Icon(data.$5,size:32,color:green)),const SizedBox(width:14),
    Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(data.$1,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800)),const SizedBox(height:4),Text(data.$2+' · '+data.$3,style:const TextStyle(color:Colors.black54)),const SizedBox(height:7),Text(data.$4,style:const TextStyle(fontWeight:FontWeight.w800))])),
    const Icon(Icons.chevron_right_rounded,color:Colors.black45),
  ]))));
}

class DetailPage extends StatelessWidget {
  final String name,type,location,price; final IconData icon;
  const DetailPage({super.key,required this.name,required this.type,required this.location,required this.price,required this.icon});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(backgroundColor:cream,elevation:0,actions:[IconButton(onPressed:(){},icon:const Icon(Icons.favorite_border_rounded))]),body:ListView(padding:const EdgeInsets.all(20),children:[
    Container(height:255,decoration:BoxDecoration(gradient:const LinearGradient(colors:[green,Color(0xFF2D7568)]),borderRadius:BorderRadius.circular(30)),child:Center(child:Icon(icon,color:Colors.white,size:90))),
    const SizedBox(height:20),Text(name,style:const TextStyle(fontSize:31,fontWeight:FontWeight.w900)),const SizedBox(height:6),Text(type+' · '+location,style:const TextStyle(color:Colors.black54,fontSize:16)),
    const SizedBox(height:15),Wrap(spacing:8,children:[_Chip(Icons.star_rounded,'4.9'),_Chip(Icons.location_on_outlined,location),_Chip(Icons.euro_rounded,price)]),
    const SizedBox(height:24),const Text('Sobre a experiência',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:9),
    const Text('Uma experiência selecionada pelo Reserva7. Consulte disponibilidade, escolha seu horário e confirme sua mesa.',style:TextStyle(color:Colors.black54,height:1.5)),
    const SizedBox(height:28),_Button(label:'Ver disponibilidade',onTap:()=>push(context,const BookingPage())),
  ]));
}
class _Chip extends StatelessWidget {
  final IconData icon; final String text;
  const _Chip(this.icon,this.text);
  @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:11,vertical:9),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(14)),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,size:15,color:green),const SizedBox(width:5),Text(text,style:const TextStyle(fontWeight:FontWeight.w700,fontSize:12))]));
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});
  @override State<BookingPage> createState()=>_BookingPageState();
}
class _BookingPageState extends State<BookingPage>{
  int date=0,time=0,people=2;
  final dates=['Hoje','Amanhã','30 Set','01 Out','02 Out'];
  final times=['19:00','19:30','20:00','20:30','21:00'];
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Fazer reserva',style:TextStyle(fontWeight:FontWeight.w800)),backgroundColor:cream,elevation:0),body:ListView(padding:const EdgeInsets.all(20),children:[
    const Text('Escolha a data',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:12),
    SizedBox(height:70,child:ListView(scrollDirection:Axis.horizontal,children:List.generate(dates.length,(i)=>GestureDetector(onTap:()=>setState(()=>date=i),child:Container(width:72,margin:const EdgeInsets.only(right:9),decoration:BoxDecoration(color:date==i?green:Colors.white,borderRadius:BorderRadius.circular(18)),alignment:Alignment.center,child:Text(dates[i],style:TextStyle(color:date==i?Colors.white:Colors.black,fontWeight:FontWeight.w800,fontSize:12)))))),
    const SizedBox(height:25),const Text('Número de pessoas',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:8),
    Row(children:[IconButton(onPressed:people>1?()=>setState(()=>people--):null,icon:const Icon(Icons.remove_circle_outline)),Text(people.toString(),style:const TextStyle(fontSize:22,fontWeight:FontWeight.w800)),IconButton(onPressed:()=>setState(()=>people++),icon:const Icon(Icons.add_circle_outline))]),
    const SizedBox(height:16),const Text('Horário',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:10),
    Wrap(spacing:8,runSpacing:8,children:List.generate(times.length,(i)=>ChoiceChip(label:Text(times[i]),selected:time==i,onSelected:(_)=>setState(()=>time=i)))),
    const SizedBox(height:30),_Button(label:'Confirmar reserva',onTap:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Reserva confirmada'),content:Text(people.toString()+' pessoas · '+dates[date]+' · '+times[time]),actions:[TextButton(onPressed:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const HomePage()),(_)=>false),child:const Text('Concluir'))]))),
  ]));
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Notificações',style:TextStyle(fontWeight:FontWeight.w800)),backgroundColor:cream,elevation:0),body:ListView(padding:const EdgeInsets.all(20),children:[
    _Notice(Icons.auto_awesome_rounded,'Novas experiências em Madrid','Descubra lugares selecionados perto de você.'),
    _Notice(Icons.event_available_rounded,'Sua próxima reserva','Tenha seus detalhes sempre à mão.'),
  ]));
}
class _Notice extends StatelessWidget {
  final IconData icon; final String title,text;
  const _Notice(this.icon,this.title,this.text);
  @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.only(bottom:10),padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(19)),child:Row(children:[
    Container(width:45,height:45,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(14)),child:Icon(icon,color:green)),const SizedBox(width:13),
    Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w800)),const SizedBox(height:4),Text(text,style:const TextStyle(color:Colors.black54))]))
  ]));
}
class _Empty extends StatelessWidget {
  final IconData icon;
  const _Empty({required this.icon});
  @override Widget build(BuildContext context)=>Container(height:190,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(30)),child:Center(child:Icon(icon,size:80,color:green)));
}
