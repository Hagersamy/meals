import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/assets/app_assets.dart';
import '../../core/database/app_database.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_style.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/primary_button_widget.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _rateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _rateController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveMeal() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final imageUrl = _imageUrlController.text.trim();
    final description = _descriptionController.text.trim();

    await AppDatabase.instance.insertMeal(
      MealsCompanion.insert(
        name: _nameController.text.trim(),
        imageUrl: imageUrl.isEmpty ? AppAssets.homeItemImg : imageUrl,
        rate: Value(double.parse(_rateController.text.trim())),
        time: '${_timeController.text.trim()} min',
        description: Value(description.isEmpty ? null : description),
      ),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meal added successfully')),
    );
    context.pop();
  }

  Widget _label(String text) => Padding(
        padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
        child: Text(text, style: AppTextStyle.black16Medium),
      );

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text('Add Meal', style: AppTextStyle.black16Medium),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            children: [
              _label('Meal Name'),
              CustomEditText(
                controller: _nameController,
                hintText: 'e.g. Vegetable Bowl',
                validator: (v) {
                  final err = _required(v);
                  if (err != null) return err;
                  if (v!.trim().length > 100) return 'Max 100 characters';
                  return null;
                },
              ),
              _label('Image URL (optional)'),
              CustomEditText(
                controller: _imageUrlController,
                hintText: 'https://...',
                keyboardType: TextInputType.url,
                validator: (v) {
                  final url = v?.trim() ?? '';
                  if (url.isNotEmpty && !url.startsWith('http')) {
                    return 'Enter a valid link starting with http';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Rate (0 - 5)'),
                        CustomEditText(
                          controller: _rateController,
                          hintText: '4.5',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (v) {
                            final err = _required(v);
                            if (err != null) return err;
                            final rate = double.tryParse(v!.trim());
                            if (rate == null || rate < 0 || rate > 5) {
                              return 'From 0 to 5';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Time (minutes)'),
                        CustomEditText(
                          controller: _timeController,
                          hintText: '20',
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            final err = _required(v);
                            if (err != null) return err;
                            final mins = int.tryParse(v!.trim());
                            if (mins == null || mins <= 0) {
                              return 'Enter minutes';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _label('Description'),
              CustomEditText(
                controller: _descriptionController,
                hintText: 'Ingredients, steps, notes...',
                maxLines: 5,
              ),
              SizedBox(height: 32.h),
              PrimaryButtonWidget(
                buttonText: _saving ? 'Saving...' : 'Save Meal',
                onPressed: _saving ? null : _saveMeal,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
