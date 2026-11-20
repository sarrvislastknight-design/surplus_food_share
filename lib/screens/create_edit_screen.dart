import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../validators.dart';

// CREATE / EDIT SCREEN: if [item] is null we are adding, otherwise editing.
class CreateEditScreen extends StatefulWidget {
  final FoodItem? item;

  const CreateEditScreen({super.key, this.item});

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _quantityCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _pickupCtrl;
  String? _category;

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    final i = widget.item;
    _titleCtrl = TextEditingController(text: i?.title ?? '');
    _quantityCtrl = TextEditingController(text: i?.quantity ?? '');
    _locationCtrl = TextEditingController(text: i?.location ?? '');
    _pickupCtrl = TextEditingController(text: i?.pickupTime ?? '');
    _category = i?.category;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _quantityCtrl.dispose();
    _locationCtrl.dispose();
    _pickupCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      // Navigator.pop sends the new/edited item back to the Dashboard.
      Navigator.pop(
        context,
        FoodItem(
          title: _titleCtrl.text.trim(),
          quantity: _quantityCtrl.text.trim(),
          location: _locationCtrl.text.trim(),
          pickupTime: _pickupCtrl.text.trim(),
          category: _category!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Listing' : 'Share Surplus Food'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Food name',
                        prefixIcon: Icon(Icons.fastfood_outlined),
                      ),
                      validator: (v) {
                        final required = validateRequired(v, 'the food name');
                        if (required != null) return required;
                        if (v!.trim().length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Row + Expanded: two fields sharing the width
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _quantityCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              hintText: 'e.g. 10 packs',
                            ),
                            validator: (v) =>
                                validateRequired(v, 'the quantity'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _category,
                            isExpanded: true,
                            decoration:
                                const InputDecoration(labelText: 'Category'),
                            items: kCategories
                                .map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c,
                                          overflow: TextOverflow.ellipsis),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() => _category = v),
                            validator: (v) =>
                                v == null ? 'Choose a category' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Pickup location',
                        prefixIcon: Icon(Icons.place_outlined),
                      ),
                      validator: (v) =>
                          validateRequired(v, 'the pickup location'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pickupCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Pickup time',
                        hintText: 'e.g. 8:00 PM today',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      validator: (v) =>
                          validateRequired(v, 'the pickup time'),
                    ),
                    const SizedBox(height: 16),
                    // Placeholder for Practical 2 (camera + location)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.photo_camera_outlined),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Photo and GPS location will be added in Practical 2',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _save,
                      child: Text(_isEditing ? 'Save Changes' : 'Post Listing'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
