import 'package:flutter/material.dart';

commonLikeButton({isSelected,onTap}) {
  return GestureDetector(
    onTap:onTap,
    child:
    isSelected ?
    const Icon(
      Icons
          .favorite,
      size: 22,
      color: Colors
          .red,
    )
        : const Icon(
      Icons
          .favorite_outline,
      size: 22,
    )
  );

}