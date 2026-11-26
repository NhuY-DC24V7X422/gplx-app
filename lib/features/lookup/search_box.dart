import 'package:flutter/material.dart';

// Ô tìm kiếm dùng chung cho Biển báo và Mức phạt
class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.hint, required this.onChanged});

  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: onChanged,
        // bấm ra ngoài thì ẩn bàn phím
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
