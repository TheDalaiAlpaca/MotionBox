//=================================================================================================
/*
    Copyright (C) 2015-2017 MotionBox authors united with omega. <http://omega.gg/about>

    Author: Benjamin Arnaud. <http://bunjee.me> <bunjee@omega.gg>

    This file is part of MotionBox.

    - GNU General Public License Usage:
    This file may be used under the terms of the GNU General Public License version 3 as published
    by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging
    of this file. Please review the following information to ensure the GNU General Public License
    requirements will be met: https://www.gnu.org/licenses/gpl.html.
*/
//=================================================================================================

import QtQuick 1.0
import Sky     1.0

BaseButtonPiano
{
    //---------------------------------------------------------------------------------------------
    // Properties
    //---------------------------------------------------------------------------------------------

    /* mandatory */ property variant itemTitle

    //---------------------------------------------------------------------------------------------
    // Private

    property int pSize: sk.textWidth(itemTitle.font, itemTitle.text) + borderSize

    //---------------------------------------------------------------------------------------------
    // Settings
    //---------------------------------------------------------------------------------------------

    width:
    {
        var margins = itemTitle.anchors.leftMargin + itemTitle.anchors.rightMargin;

        if (borderRight)
        {
             return pSize + margins;
        }
        else return itemTitle.width + margins;
    }

    borderRight: (pSize < itemTitle.width) ? borderSize : 0
}
