import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../utils/extensions.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? button1;
  final String button2;
  final Color? color1;
  final Color? color2;
  final Function()? onTap1;
  final Function()? onTap2;

  const DialogWidget({
    required this.title,
    required this.button2,
    this.subtitle,
    this.button1,
    this.onTap1,
    this.onTap2,
    super.key,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.only(left: 53.width, right: 52.width),
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.darkGrey3,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.fromLTRB(17.width, 59.height, 17.width, 56.height),
              child: Column(
                children: [
                  Text(title,
                      style: AppTextStyles.p1Bold.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,),
                  SizedBox(
                    height: 11.height,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.p2.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.middleGrey),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.5.height,
                          bottom: 9.height,
                        ),
                        child: InkWell(
                          onTap: onTap1 ?? () => Navigator.pop(context),
                          child: Text(
                            button1 ?? S.of(context).cancel,
                            style: AppTextStyles.p2Bold
                                .copyWith(color: color1 ?? AppColors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.middleGrey,
                      width: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.5.height,
                          bottom: 9.height,
                        ),
                        child: InkWell(
                          onTap: onTap2 ?? () => Navigator.pop(context),
                          child: Text(
                            button2,
                            style: AppTextStyles.p2Bold.copyWith(
                              color: color2 ?? AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
