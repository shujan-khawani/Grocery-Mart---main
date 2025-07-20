// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Reusable error widget for consistent error display
class AppErrorWidget extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final ErrorType type;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.retryButtonText,
    this.icon,
    this.type = ErrorType.general,
  });

  /// Network error widget
  const AppErrorWidget.network({
    super.key,
    this.message =
        'No internet connection. Please check your network and try again.',
    this.title = 'Connection Error',
    this.onRetry,
    this.retryButtonText = 'Retry',
  }) : icon = Icons.wifi_off,
       type = ErrorType.network;

  /// Server error widget
  const AppErrorWidget.server({
    super.key,
    this.message = 'Something went wrong on our end. Please try again later.',
    this.title = 'Server Error',
    this.onRetry,
    this.retryButtonText = 'Retry',
  }) : icon = Icons.error_outline,
       type = ErrorType.server;

  /// Not found error widget
  const AppErrorWidget.notFound({
    super.key,
    this.message = 'The requested content could not be found.',
    this.title = 'Not Found',
    this.onRetry,
    this.retryButtonText = 'Go Back',
  }) : icon = Icons.search_off,
       type = ErrorType.notFound;

  /// Permission error widget
  const AppErrorWidget.permission({
    super.key,
    this.message = 'You don\'t have permission to access this content.',
    this.title = 'Access Denied',
    this.onRetry,
    this.retryButtonText = 'Try Again',
  }) : icon = Icons.lock_outline,
       type = ErrorType.permission;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = _getErrorColor(theme);
    final errorIcon = icon ?? _getDefaultIcon();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(errorIcon, size: 64, color: errorColor),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(_getRetryIcon()),
                label: Text(retryButtonText ?? 'Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: errorColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getErrorColor(ThemeData theme) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange;
      case ErrorType.server:
        return Colors.red;
      case ErrorType.notFound:
        return Colors.grey;
      case ErrorType.permission:
        return Colors.amber;
      case ErrorType.general:
        return theme.colorScheme.error;
    }
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.error_outline;
      case ErrorType.notFound:
        return Icons.search_off;
      case ErrorType.permission:
        return Icons.lock_outline;
      case ErrorType.general:
        return Icons.error_outline;
    }
  }

  IconData _getRetryIcon() {
    switch (type) {
      case ErrorType.network:
        return Icons.refresh;
      case ErrorType.server:
        return Icons.refresh;
      case ErrorType.notFound:
        return Icons.arrow_back;
      case ErrorType.permission:
        return Icons.refresh;
      case ErrorType.general:
        return Icons.refresh;
    }
  }
}

/// Inline error widget for forms and smaller spaces
class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;
  final Color? backgroundColor;
  final Color? textColor;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.onDismiss,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? Colors.red.shade50;
    final txtColor = textColor ?? Colors.red.shade700;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: txtColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: txtColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: txtColor),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: txtColor, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}

/// Success message widget
class SuccessWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;
  final Color? backgroundColor;
  final Color? textColor;

  const SuccessWidget({
    super.key,
    required this.message,
    this.onDismiss,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? Colors.green.shade50;
    final txtColor = textColor ?? Colors.green.shade700;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: txtColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: txtColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: txtColor),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: txtColor, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}

/// Warning message widget
class WarningWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;
  final Color? backgroundColor;
  final Color? textColor;

  const WarningWidget({
    super.key,
    required this.message,
    this.onDismiss,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? Colors.orange.shade50;
    final txtColor = textColor ?? Colors.orange.shade700;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: txtColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_outlined, color: txtColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: txtColor),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: txtColor, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error types enum
enum ErrorType { general, network, server, notFound, permission }

/// Error handler utility class
class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    } else {
      return 'An unexpected error occurred';
    }
  }

  static ErrorType getErrorType(dynamic error) {
    final message = getErrorMessage(error).toLowerCase();

    if (message.contains('network') ||
        message.contains('connection') ||
        message.contains('internet')) {
      return ErrorType.network;
    } else if (message.contains('server') ||
        message.contains('500') ||
        message.contains('503')) {
      return ErrorType.server;
    } else if (message.contains('not found') || message.contains('404')) {
      return ErrorType.notFound;
    } else if (message.contains('permission') ||
        message.contains('unauthorized') ||
        message.contains('403')) {
      return ErrorType.permission;
    } else {
      return ErrorType.general;
    }
  }

  static Widget buildErrorWidget({
    required dynamic error,
    VoidCallback? onRetry,
    String? retryButtonText,
  }) {
    final errorMessage = getErrorMessage(error);
    final errorType = getErrorType(error);

    switch (errorType) {
      case ErrorType.network:
        return AppErrorWidget.network(
          message: errorMessage,
          onRetry: onRetry,
          retryButtonText: retryButtonText,
        );
      case ErrorType.server:
        return AppErrorWidget.server(
          message: errorMessage,
          onRetry: onRetry,
          retryButtonText: retryButtonText,
        );
      case ErrorType.notFound:
        return AppErrorWidget.notFound(
          message: errorMessage,
          onRetry: onRetry,
          retryButtonText: retryButtonText,
        );
      case ErrorType.permission:
        return AppErrorWidget.permission(
          message: errorMessage,
          onRetry: onRetry,
          retryButtonText: retryButtonText,
        );
      case ErrorType.general:
        return AppErrorWidget(
          message: errorMessage,
          onRetry: onRetry,
          retryButtonText: retryButtonText,
        );
    }
  }
}
