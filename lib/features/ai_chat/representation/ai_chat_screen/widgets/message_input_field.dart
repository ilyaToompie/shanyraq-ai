import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                hintText: 'type-a-message'.tr(),
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onSend,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
