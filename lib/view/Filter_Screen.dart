import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/property_controller.dart';
import 'filter_result.dart';

class FilterPage extends StatefulWidget {
  final String listingType; // "sale" أو "rent"

  FilterPage({required this.listingType});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final PropertyController propertyController = Get.put(PropertyController());

  int selectedPropertyIndex = 0;
  List<Map<String, dynamic>> propertyTypes = [
    {'label': 'أرض', 'icon': Icons.terrain},
    {'label': 'شقة', 'icon': Icons.apartment},
    {'label': 'فيلا', 'icon': Icons.house},
    {'label': 'متجر', 'icon': Icons.store},
    {'label': 'مزرعة', 'icon': Icons.agriculture},
  ];

  int? selectedRoomCount;

  final TextEditingController minAreaController = TextEditingController();
  final TextEditingController maxAreaController = TextEditingController();

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  // 'دمشق', 'ريف دمشق', 'حلب', 'حمص', 'حماة',
    // 'اللاذقية', 'طرطوس', 'درعا', 'السويداء',
    // 'القنيطرة', 'دير الزور', 'الرقة', 'الحسكة'
  final List<String> provinces = [
    'دمشق',
    'ريف دمشق',
            'درعا',
            'السويداء',
            'القنيطرة',
            'حمص',
            'حماة',
            'طرطوس',
            'اللاذقية',
            'إدلب',
            'حلب',
            'الرقة',
            'دير الزور',
            'الحسكة',
  ];
  String? selectedProvince;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // ضبط السعر الأدنى مبدئياً حسب نوع العقار
    if (widget.listingType == "sale") {
      minPriceController.text; // سعر مبدئي للبيع
    } else {
      minPriceController.text; // سعر مبدئي للإيجار
    }
  }

  String? validateArea(String? value, {required bool isMin}) {
    if (value == null || value.isEmpty) return null; // اختياري

    final intVal = int.tryParse(value);
    if (intVal == null) return 'رقم غير صالح';

    if (intVal < 30) return 'يجب ألا تقل المساحة عن 30م';
    if (intVal > 1000) return 'الحد الأقصى 1000م';

    final min = int.tryParse(minAreaController.text);
    final max = int.tryParse(maxAreaController.text);

    if (min != null && max != null && max <= min) {
      return isMin ? null : 'يجب أن تكون القيمة أكبر من البداية';
    }

    return null;
  }

  String? validatePrice(String? value, {required bool isMin}) {
    if (value == null || value.isEmpty) return null; // اختياري

    final intVal = int.tryParse(value);
    if (intVal == null) return 'رقم غير صالح';

    // if (intVal < 100000) return 'يجب ألا يقل السعر عن 100,000';
    // if (intVal > 10000000) return 'الحد الأقصى 10,000,000';

    final min = int.tryParse(minPriceController.text);
    final max = int.tryParse(maxPriceController.text);

    if (min != null && max != null && max <= min) {
      return isMin ? null : 'القيمة القصوى يجب أن تكون أكبر من البداية';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    String selectedTypeLabel = propertyTypes[selectedPropertyIndex]['label'];
    bool hideRooms = selectedTypeLabel == 'متجر' || selectedTypeLabel == 'أرض';

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.lightBlue.shade300, width: 2),
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[400],
          elevation: 4,
          title: Text(
            'فلترة العقارات (${widget.listingType == "sale" ? "للبيع" : "للإيجار"})',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          shadowColor: Colors.lightBlue.shade200,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نوع العقار
                Text(
                  'نوع العقار',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  height: 105,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: propertyTypes.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedPropertyIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPropertyIndex = index;
                            selectedRoomCount = null;
                            minAreaController.clear();
                            maxAreaController.clear();
                            minPriceController.clear();
                            maxPriceController.clear();
                            selectedProvince = null;

                            // إعادة ضبط السعر الأدنى حسب نوع العقار بعد اختيار نوع جديد
                            if (widget.listingType == "sale") {
                              minPriceController.text = "500000";
                            } else {
                              minPriceController.text = "100000";
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 115,
                          margin: EdgeInsets.only(right: 14),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.lightBlue[100] : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? Colors.lightBlue : Colors.grey.shade300,
                              width: isSelected ? 3 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.lightBlue.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                propertyTypes[index]['icon'],
                                size: 34,
                                color: isSelected ? Colors.lightBlue[700] : Colors.grey[600],
                              ),
                              SizedBox(height: 10),
                              Text(
                                propertyTypes[index]['label'],
                                style: TextStyle(
                                  color: isSelected ? Colors.lightBlue[800] : Colors.grey[700],
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 28),

                // المحافظة
                Text(
                  'المحافظة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedProvince,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: focusedBorder,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  hint: Text('اختر المحافظة', style: TextStyle(color: Colors.grey[600])),
                  items: provinces.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProvince = value;
                    });
                  },
                ),

                SizedBox(height: 28),

                // عدد الغرف
                if (!hideRooms) ...[
                  Text(
                    'عدد الغرف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  SizedBox(height: 14),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(8, (index) {
                        final number = index + 1;
                        final isSelected = selectedRoomCount == number;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected ? Colors.lightBlue[300] : Colors.white,
                              foregroundColor: isSelected ? Colors.blue[900] : Colors.grey[600],
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              elevation: isSelected ? 4 : 0,
                              shadowColor: isSelected ? Colors.lightBlue.shade200 : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedRoomCount = number;
                              });
                            },
                            child: Text(
                              number.toString(),
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 28),
                ],

                // مجال المساحة
                Text(
                  'المساحة (م²)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: minAreaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'من',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Colors.white,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        validator: (value) => validateArea(value, isMin: true),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: TextFormField(
                        controller: maxAreaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'إلى',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Colors.white,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        validator: (value) => validateArea(value, isMin: false),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                // مجال السعر
                Text(
                  'السعر (ل.س)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'من',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Colors.white,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        validator: (value) => validatePrice(value, isMin: true),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: TextFormField(
                        controller: maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'إلى',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Colors.white,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        validator: (value) => validatePrice(value, isMin: false),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 35),

                // زر تطبيق الفلاتر و إعادة التعيين
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.lightBlue[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                        onPressed: () async {

  if (_formKey.currentState!.validate()) {
    final selectedType = propertyTypes[selectedPropertyIndex]['label'];

    await propertyController.filterProperties(
      type: widget.listingType,
      name: selectedType,
      rooms: selectedRoomCount,
      areaMin: minAreaController.text.isNotEmpty
          ? double.tryParse(minAreaController.text)
          : null,
      areaMax: maxAreaController.text.isNotEmpty
          ? double.tryParse(maxAreaController.text)
          : null,
      priceMin: minPriceController.text.isNotEmpty
          ? int.tryParse(minPriceController.text)
          : null,
      priceMax: maxPriceController.text.isNotEmpty
          ? int.tryParse(maxPriceController.text)
          : null,
      province: 4,
    );
    await Get.to(() => FilterResault());
  }

                            },
                      child: Text('تطبيق الفلاتر', style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedPropertyIndex = 0;
                          selectedRoomCount = null;
                          minAreaController.clear();
                          maxAreaController.clear();
                          maxPriceController.clear();
                          selectedProvince = null;

                          // إعادة تعيين السعر الأدنى حسب نوع العقار بعد إعادة التعيين
                          if (widget.listingType == "sale") {
                            minPriceController.text = "500000";
                          } else {
                            minPriceController.text = "100000";
                          }
                        });
                      },
                      child: Text('إعادة تعيين', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
