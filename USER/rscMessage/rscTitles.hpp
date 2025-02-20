#include "baseDefines.hpp"
#include "baseRsc.hpp"

class rscKraken
    {
        fadein = 0;
        fadeout = 0;
        duration = 1e+011;
        onLoad = "uinamespace setvariable ['GRAD_RSC_KRAKEN',_this select 0]";
        onUnLoad = "uinamespace setvariable ['GRAD_RSC_KRAKEN',nil]";

        class Controls
        {
            class LogoCorner: grad_customRsc_RscPicture
            {
                x = "safezoneX + safezoneW - 7 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                y = "safezoneY + 1 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "6 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                h = "3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                colorText[] = {1, 1, 1, 0.25};
                text = "data\kraken_logo_corner.paa";
            };
            class BackgroundMain: grad_customRsc_RscText
            {
                x = "safezoneX";
                y = "safezoneY + safezoneH - 4.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "safezoneW";
                h = "3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                colorBackground[] = {0, 0, 0, 0.6};
            };
            class Logo: grad_customRsc_RscPicture
            {
                x = "safezoneX + 0.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                y = "safezoneY + safezoneH - 4.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "12 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                h = "3 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                text = "data\kraken_logo.paa";
            };
            class Title: grad_customRsc_RscStructuredText
            {
                idc = 9001;
                x = "safezoneX + 10.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                y = "safezoneY + safezoneH - 4.25 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "safezoneW - 10.5 * 	(1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                h = "2.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                shadow = 0;
                class Attributes
                {
                    font = "PuristaMedium";
                    color = "#ffffff";
                    align = "left";
                    shadow = 0;
                };
            };
            class LineBlack: BackgroundMain
            {
                y = "safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 2 * pixelH";
                h = "2 * pixelH";
                colorBackground[] = {0, 0, 0, 1};
            };
            class BackgroundStripe: BackgroundMain
            {
                y = "safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                h = "(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                colorBackground[] = {0, 0, 0, 1};
            };
            class Stripe: grad_customRsc_RscControlsGroupNoScrollbars
            {
                x = "safezoneX";
                y = "safezoneY + safezoneH - 1.5 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "safezoneW";
                h = "(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                class Controls
                {
                    class StripeText1: grad_customRsc_RscStructuredText
                    {
                        idc = 9002;
                        x = 0;
                        y = 0;
                        w = "safezoneW";
                        h = "(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                        shadow = 0;
                        size = "0.9 * 	(1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                        class Attributes
                        {
                            font = "PuristaLight";
                            color = "#000000";
                            align = "left";
                            shadow = 0;
                        };
                    };
                    class StripeText2: StripeText1
                    {
                        idc = 9004;
                    };
                };
            };
        };
};