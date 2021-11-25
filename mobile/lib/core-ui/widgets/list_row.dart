import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  const ListRow({
    Key? key,
    required Widget leadingIcon,
    required Widget title,
    required VoidCallback onTapped,
    EdgeInsets? padding,
  })  : _leadingIcon = leadingIcon,
        _title = title,
        _onTapped = onTapped,
        _padding = padding,
        super(key: key);

  final Widget _leadingIcon;
  final Widget _title;
  final VoidCallback _onTapped;
  final EdgeInsets? _padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: _onTapped,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _leadingIcon,
              ),
              _title,
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
