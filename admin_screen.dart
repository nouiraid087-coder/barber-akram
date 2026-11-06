import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool isShopOpen = true;
  bool isQueueOpen = true;
  String currentCustomer = "أحمد (رقم #04)";
  List<String> waitingList = ["محمد (رقم #05)", "خالد (رقم #06)", "إسلام (رقم #07)"];

  void nextCustomer() {
    setState(() {
      if (waitingList.isNotEmpty) {
        currentCustomer = waitingList.removeAt(0);
      } else {
        currentCustomer = "لا يوجد زبائن حالياً";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'لوحة تحكم الحلاق - BARBER AKRAM',
          style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // أزرار التحكم بالحالة العامة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => setState(() => isShopOpen = !isShopOpen),
                  icon: Icon(isShopOpen ? Icons.store : Icons.store_mall_directory, color: Colors.black),
                  label: Text(isShopOpen ? 'المحل: مفتوح' : 'المحل: مغلق', style: const TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: isShopOpen ? Colors.green : Colors.red),
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() => isQueueOpen = !isQueueOpen),
                  icon: Icon(isQueueOpen ? Icons.lock_open : Icons.lock, color: Colors.black),
                  label: Text(isQueueOpen ? 'الطابور: متاح' : 'الطابور: متوقف', style: const TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: isQueueOpen ? const Color(0xFFD4AF37) : Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // بطاقة الزبون الحالي على الكرسي
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('الزبون الحالي على الكرسي:', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                    currentCustomer,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: nextCustomer,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('إنهاء الخدمة والتالي', style: TextStyle(color: Colors.white)),
                      ),
                      OutlinedButton(
                        onPressed: nextCustomer,
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                        child: const Text('تجاوز الغائب', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // قائمة الانتظار الحية
            const Text(
              'قائمة المنتظرين في الطابور:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(height: 10),
            ...waitingList.map((customer) => Card(
                  color: const Color(0xFF1A1A1A),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFFD4AF37)),
                    title: Text(customer, style: const TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          waitingList.remove(customer);
                        });
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
