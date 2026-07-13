import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class SuggestionsDropdown extends StatefulWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionSelected;
  final bool isVisible;
  final double maxHeight;

  const SuggestionsDropdown({
    super.key,
    required this.suggestions,
    required this.onSuggestionSelected,
    required this.isVisible,
    this.maxHeight = 200,
  });

  @override
  State<SuggestionsDropdown> createState() => _SuggestionsDropdownState();
}

class _SuggestionsDropdownState extends State<SuggestionsDropdown> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible || widget.suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = widget.suggestions[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onSuggestionSelected(suggestion),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  suggestion,
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.lightGrey2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
