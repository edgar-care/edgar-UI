import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';

/// Enum for the different
enum ModalType {
  /// Modal for display some information
  info,

  /// To display something dangerous, a warning or error
  error,

  /// To display something like a modal to add or in succes
  success,
}

/// Class BottomSheetModel to define a switch between different modal
class BottomSheetModel extends ChangeNotifier {
  int _currentPageIndex = 0;

  /// Getter for the current Page index
  int get getCurrentPageIndex => _currentPageIndex;

  /// Function to reset the Page index at 0
  void resetCurrentIndex() {
    _currentPageIndex = 0;
    notifyListeners();
  }

  /// Function that take a Int to swap to this page
  void changePage(int pageIndex) {
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}

/// Function to define all the different page
class ListModal extends StatefulWidget {
  /// All the different page
  final List<Widget> children;

  /// The BottomSheet model
  final BottomSheetModel? model;

  /// Required the children and the model
  const ListModal({super.key, required this.children, this.model});

  @override
  ListModalState createState() => ListModalState();
}

/// State of the ListModal
class ListModalState extends State<ListModal>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < widget.children.length; i++)
                if (widget.model != null)
                  Visibility(
                    visible: widget.model!.getCurrentPageIndex == i,
                    maintainState: true,
                    child: widget.children[i],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Container of the modal to get is body
class ModalContainer extends StatelessWidget {
  /// Tittle of the modal
  final String title;

  /// Icon de la modal
  final Widget icon;

  /// Subtittle of the modal
  final String subtitle;

  /// The body of the modal
  final List<Widget>? body;

  /// The footer of the modal
  final Widget? footer;

  /// Required Tittle, subtittle, and Icon
  const ModalContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.body,
    this.footer,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        // padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                height: 1.5,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: Colors.black,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                height: 1.5,
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: AppColors.grey700,
              ),
              softWrap: true,
            ),
            if (body != null) ...[
              const SizedBox(height: 24),
              SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(), // Optional: Add bounce effect
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        264, // Adjust as needed
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body!,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

/// The Icon of the modal
class IconModal extends StatelessWidget {
  /// The Icon
  final Widget icon;

  /// The type of the modal,  the color change in function of the type
  final ModalType type;

  /// Required The icon, and the type
  const IconModal({super.key, required this.icon, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: type == ModalType.info
            ? AppColors.blue100
            : type == ModalType.error
                ? AppColors.red200
                : AppColors.green200,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: icon,
    );
  }
}
