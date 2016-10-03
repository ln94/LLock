//
//  RoamGeometry.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Insets

typedef UIEdgeInsets CGInsets;

#define CGInsetsZero UIEdgeInsetsZero

CG_INLINE CGInsets
insets(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left)
{
    return (CGInsets){top, left, bottom, right};
}

CG_INLINE CGInsets
i(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left)
{
    return (CGInsets){top, left, bottom, right};
}

CG_INLINE CGInsets
inset(CGFloat inset)
{
    return (CGInsets){inset, inset, inset, inset};
}

CG_INLINE CGInsets
insets_add(CGInsets inset, CGInsets add)
{
    return (CGInsets){inset.top + add.top, inset.left + add.left, inset.bottom + add.bottom, inset.right + add.right};
}


#pragma mark - Rect

CG_INLINE CGRect
rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return CGRectMake(x, y, width, height);
}

CG_INLINE CGRect
r(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    return CGRectMake(x, y, width, height);
}

CG_INLINE CGRect
rect_origin(CGPoint origin, CGSize size)
{
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

CG_INLINE CGRect
rect_size(CGSize size)
{
    return CGRectMake(0, 0, size.width, size.height);
}

CG_INLINE CGRect
rect_square(CGFloat size)
{
    return CGRectMake(0, 0, size, size);
}

CG_INLINE CGRect
rect_inset(CGRect rect, CGInsets insets)
{
    return CGRectMake(rect.origin.x + insets.left, rect.origin.y + insets.top, rect.size.width - insets.left - insets.right, rect.size.height - insets.top - insets.bottom);
}

CG_INLINE CGRect
rect_center(CGSize size, CGPoint center)
{
    return CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height);
}

#pragma mark - Point

CG_INLINE CGPoint
point(CGFloat x, CGFloat y)
{
    return CGPointMake(x, y);
}

CG_INLINE CGPoint
p(CGFloat x, CGFloat y)
{
    return CGPointMake(x, y);
}

CG_INLINE CGPoint
point_center_rect(CGRect rect)
{
    return CGPointMake(rect.origin.x + (rect.size.width / 2), rect.origin.y + (rect.size.height / 2));
}

#pragma mark - Size

CG_INLINE CGSize
size(CGFloat width, CGFloat height)
{
    return CGSizeMake(width, height);
}

CG_INLINE CGSize
s(CGFloat width, CGFloat height)
{
    return CGSizeMake(width, height);
}

CG_INLINE CGSize
size_square(CGFloat length)
{
    return CGSizeMake(length, length);
}

CG_INLINE CGInsets
insets_x_y(CGFloat x, CGFloat y)
{
    return i(y, x, y, x);
}

CG_INLINE CGInsets
insets_x(CGFloat x)
{
    return i(0, x, 0, x);
}

CG_INLINE CGInsets
insets_y(CGFloat y)
{
    return i(y, 0, y, 0);
}

CG_INLINE CGInsets
inset_top(CGFloat top)
{
    return i(top, 0, 0, 0);
}

CG_INLINE CGInsets
inset_right(CGFloat right)
{
    return i(0, right, 0, 0);
}

CG_INLINE CGInsets
inset_bottom(CGFloat bottom)
{
    return i(0, 0, bottom, 0);
}

CG_INLINE CGInsets
inset_left(CGFloat left)
{
    return i(0, 0, 0, left);
}


#pragma mark - Transform

CG_INLINE CGAffineTransform
transform_rotation(CGFloat rotation)
{
    return CGAffineTransformMakeRotation(rotation);
}

CG_INLINE CGAffineTransform
transform_scale(CGFloat scale)
{
    return CGAffineTransformMakeScale(scale, scale);
}

CG_INLINE CGAffineTransform
transform(CGFloat rotation, CGFloat scale)
{
    return CGAffineTransformScale(CGAffineTransformMakeRotation(rotation), scale, scale);
}