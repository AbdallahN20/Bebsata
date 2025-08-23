import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'settings_page.dart';


const Map<String, IconData> kPages = {
  'Home': Icons.home,
  'Cart': Icons.shopping_cart,
  'Delivery': Icons.delivery_dining,
  'Account': Icons.account_circle,
};

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const Center(child: Text('صفحة رئيسية', style: TextStyle(fontSize: 24))),
    const Center(child: Text('صفحة السلة', style: TextStyle(fontSize: 24))),
    const Center(child: Text('صفحة التوصيل', style: TextStyle(fontSize: 24))),
    const Center(child: Text('صفحة الحساب', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kPages.length,
      initialIndex: 0,
      child: Builder( // هذا الـ Builder يضمن أن الـ context التالي يرى الـ DefaultTabController
        builder: (BuildContext tabControllerContext) {
          final TabController tabController = DefaultTabController.of(tabControllerContext);

          // تم إزالة الـ Builder الثاني لأنه لم يعد ضروريًا بعد استخدام GlobalKey
          return Scaffold(
            key: _scaffoldkey, // اسناد الـ GlobalKey للـ Scaffold

            appBar: AppBar(
              title: const Text('Bebsata'),
              centerTitle: true,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // استخدام GlobalKey للوصول إلى ScaffoldState وفتح الـ Drawer
                  _scaffoldkey.currentState?.openDrawer(); // <--- تصحيح هنا
                },
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.teal),
                    child: Text(
                      'قائمة التطبيق',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.message),
                    title: const Text('الرسائل'),
                    onTap: () {
                      // استخدام GlobalKey لإغلاق الـ Drawer
                      Navigator.pop(context); // <--- تصحيح هنا (تم حذف Navigator.pop(scaffoldContext);)
                      // TODO: أضف كود الانتقال لصفحة الرسائل هنا
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('الملف الشخصي'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: أضف كود الانتقال لصفحة الملف الشخصي هنا
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('الإعدادات'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => setting_page()));

                      // TODO: أضف كود الانتقال لصفحة الإعدادات هنا

                    },
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: _pages,
            ),
            bottomNavigationBar: ConvexAppBar(
              controller: tabController,
              items: kPages.entries.map((entry) {
                return TabItem(icon: entry.value, title: entry.key);
              }).toList(),
              onTap: (int i) {
                tabController.animateTo(i);
              },
              backgroundColor: Colors.teal,
              activeColor: Colors.white,
              color: Colors.white,
              style: TabStyle.reactCircle,
              height: 60,
              curveSize: 80,
            ),
          );
        },
      ),
    );
  }
}

