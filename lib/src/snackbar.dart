import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_svg/svg.dart';

/// Snackbar when it a sucess case
class SuccessSnackBar extends SnackBar {
  /// Taking the message that you want to display
  final String message;

  /// Take in parameter the message and the context
  SuccessSnackBar(
      {super.key, required this.message, required BuildContext context})
      : super(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          backgroundColor: AppColors.green400,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.green500, width: 2),
            borderRadius: BorderRadius.circular(64),
          ),
          content: Row(children: [
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: AppColors.green600,
                shape: BoxShape.circle,
              ),
              child: const Icon(BootstrapIcons.check,
                  color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Text(message,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ]),
        );
}

/// Snackbar when we got an Error
class ErrorSnackBar extends SnackBar {
  /// Taking the message that you want to display
  final String message;

  /// Take in parameter the message and the context
  ErrorSnackBar(
      {super.key, required this.message, required BuildContext context})
      : super(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          backgroundColor: AppColors.red400,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.red500, width: 2),
            borderRadius: BorderRadius.circular(64),
          ),
          content: Row(children: [
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: AppColors.red600,
                shape: BoxShape.circle,
              ),
              child: const Icon(BootstrapIcons.exclamation_triangle,
                  color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Une erreur est survenue",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold)),
              Text(message,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12)),
            ]),
          ]),
        );
}

/// Snackbar when you whant to display any Information
class InfoSnackBar extends SnackBar {
  /// Taking the message that you want to display
  final String message;

  /// Take in parameter the message and the context
  InfoSnackBar(
      {super.key, required this.message, required BuildContext context})
      : super(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(minutes: 1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          backgroundColor: AppColors.blue600,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.blue700, width: 2),
            borderRadius: BorderRadius.circular(64),
          ),
          content: Row(children: [
            const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
                backgroundColor: AppColors.green400),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(message,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold)),
            ]),
          ]),
        );
}

/// Snacknar in case of success
class TopSuccessSnackBar extends StatelessWidget {
  /// Taking the message that you want to display
  final String message;

  ///   Callback when the snackbar is dismissed
  final VoidCallback? onDismissed;

  /// Constructor
  const TopSuccessSnackBar({
    super.key,
    required this.message,
    this.onDismissed,
  });

  /// Show the snackbar on top
  void show(BuildContext context) {
    OverlayState? overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 32, // Position from top
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            onEnd: () {
              Future.delayed(const Duration(seconds: 2), () {
                overlayEntry.remove();
                onDismissed?.call();
              });
            },
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -50 * (1 - value)),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.green200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.green300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value.clamp(0.0, 1.0),
                              child: SvgPicture.asset(
                                'assets/images/utils/validateSnackBar.svg',
                                width: 16,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: Transform.translate(
                                  offset: Offset(20 * (1 - value), 0),
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Snackbar when we got an Error
class TopErrorSnackBar extends StatelessWidget {
  /// Taking the message that you want to display²
  final String message;

  /// Callback when the snackbar is dismissed
  final VoidCallback? onDismissed;

  /// Constructor
  const TopErrorSnackBar({
    super.key,
    required this.message,
    this.onDismissed,
  });

  /// Show the snackbar on top
  void show(BuildContext context) {
    OverlayState? overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 32, // Position from top
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            onEnd: () {
              Future.delayed(const Duration(seconds: 2), () {
                overlayEntry.remove();
                onDismissed?.call();
              });
            },
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -50 * (1 - value)),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.red200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.red300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value.clamp(0.0, 1.0),
                              child: SvgPicture.asset(
                                'assets/images/utils/attentionSnackBar.svg',
                                width: 16,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: Transform.translate(
                                  offset: Offset(20 * (1 - value), 0),
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Snackbar when you whant to display any Information
class TopInfoSnackBar extends StatelessWidget {
  /// Taking the message that you want to display
  final String message;

  /// Callback when the snackbar is dismissed
  final VoidCallback? onDismissed;

  /// Taking the description that you want to display
  final String? description;

  /// Constructor
  const TopInfoSnackBar({
    super.key,
    required this.message,
    this.onDismissed,
    this.description,
  });

  /// Show the snackbar on top
  void show(BuildContext context) {
    OverlayState? overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 32, // Position from top
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            onEnd: () {
              Future.delayed(const Duration(seconds: 2), () {
                overlayEntry.remove();
                onDismissed?.call();
              });
            },
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -50 * (1 - value)),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.blue200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.blue300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value.clamp(0.0, 1.0),
                              child: SvgPicture.asset(
                                'assets/images/utils/InfoSnackBar.svg',
                                width: 16,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: Transform.translate(
                                    offset: Offset(20 * (1 - value), 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        if (description != null)
                                          Text(
                                            description!,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Snacknar for loading on top
class TopLoadingSnackBar extends StatelessWidget {
  /// Callback when the snackbar is dismissed
  final VoidCallback? onDismissed;

  /// Constructor
  const TopLoadingSnackBar({
    super.key,
    this.onDismissed,
  });

  /// Show the snackbar
  void show(BuildContext context) {
    OverlayState? overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 32,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            onEnd: () {
              Future.delayed(const Duration(seconds: 2), () {
                overlayEntry.remove();
                onDismissed?.call();
              });
            },
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -50 * (1 - value)),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.blue200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.blue300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.elasticOut,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value.clamp(0.0, 1.0),
                                    child: const Text(
                                      "Connexion à l'application",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value.clamp(0.0, 1.0),
                                    child: SizedBox(
                                      height: 4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: const LinearProgressIndicator(
                                          value: null, // Indeterminate progress
                                          backgroundColor: AppColors.blue100,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            AppColors.blue700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Fonction utilitaire pour faciliter l'affichage
void showTopLoadingSnackBar(BuildContext context) {
  const TopLoadingSnackBar().show(context);
}
