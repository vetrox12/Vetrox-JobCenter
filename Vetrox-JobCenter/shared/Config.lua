Config = {}

Exports = {
    core = "qb-core", -- اسم الكور حقك
    Target = "qb-target" -- اسم سكربت العين حقك
}

UI = {
    UiLanguage = "ar", -- لو تبي الجوب سنتر انقليزي خليه en وببتتغير للنظام الانقليزي
    Locales = {
        ["en"] = { -- للانقليزي
            ["TitleOfBackground"] = "Job Center", -- العنوان الرئيسي الي يطلع فوق اول شي
            ["TitleOfBioJob"] = ":Job Details", -- تفاصيل الوظيفة بالانقليزي
            ["TakeTheJob"] = "Take Job", -- اخذ الوظيفة بالانقليزي
            ["GpsTheJob"] = "Mark Location", -- تحديد الموقع بالانقليزي
            ["TakeJobNotify"] = "You were hired by", -- الاشعار الي يجيك اذا توظف اللاعب 
            ["MarkLocateNotify"] = "The location is marked on the map", -- الاشعار الي يجيك اذا حدد الموقع بالخريطة
        },
        ["ar"] = { -- للعربي
            ["TitleOfBackground"] = "مركز الوظائف العامة", -- ui
            ["TitleOfBioJob"] = "تفاصيل الوظيفة:", -- ui
            ["TakeTheJob"] = "اخذ الوظيفة", -- ui
            ["GpsTheJob"] = "تحديد الموقع", -- ui
            ["TakeJobNotify"] = "تم توظيفك في", -- الاشعار الي يجيك اذا توظف اللاعب 
            ["MarkLocateNotify"] = "تم تحديد الموقع في الخريطة", -- الاشعار الي يجيك اذا حدد الموقع بالخريطة
        }
    }
}

Config = {
    targets = { -- بوتات المحكمه او حق الوظايف (مربوطين بالعين او الي هو التارقت)
        [1] --[[ الاسم الي بالعين ]] = {
            vector3 = vector3(-535.4639, -212.3847, 37.64979), -- /pzcreate
            info1 = 1.2, -- /pzcreate
            info2 = 1.2, -- /pzcreate
            heading = 30, -- /pzcreate
            minZ = 36.649791717529, -- /pzcreate
            maxZ = 39.049791717529, -- /pzcreate
            TargetLabel = "مركز الوظايف", -- الكلام الي يجي بالعين
            ped = "s_m_m_armoured_01", -- اسم البوت
            blip = { -- البلب الي يجي بالخريطة
                sprite = 419, -- رقم البلب https://docs.fivem.net/docs/game-references/blips/
                color = 4, -- لون البلب https://docs.fivem.net/docs/game-references/blips/
                scale = 0.9, -- حجم البلب https://docs.fivem.net/docs/game-references/blips/
                label = "Job Center" -- الاسم الي يجي بالبلب
            },
        },
    },

    Jobs = { -- الوظايف
        [1] = {
            JobLabelText = "شركة المواصلات العامة", -- اسم الوظيفة داخل الجوب سنتر
            JobLabelIcon = "fa-solid fa-briefcase", -- https://fontawesome.com/
            JobImageLink = "https://media.discordapp.net/attachments/1062854469165006889/1342107496344453130/pixelcut-export.png?ex=67b86e82&is=67b71d02&hm=2011fd507de4e0ee66d7507d57e76cab3991aca6c283fa18678bbcd79c5b601e&=&format=webp&quality=lossless&width=1440&height=627", -- رابط صورة البايو // 1716 على 748 هذا مقاس الصورة
            JobBioText =  "فيتروكس هنا فلا خوف عليكم", -- البايو او الدسكربشن حق الوظيفة
            Job = "taxi", -- اسم الوظيفة داخل اللعبه
            JobGrade = 0, -- لفل الوظيفة او الرتبة كم رقمها
            JobCoords = vector3(0, 0, 0) -- احداثيات الوظيفة بحدد عليها
        },
        [2] = {
            JobLabelText = "شركة النقل البري", -- اسم الوظيفة داخل الجوب سنتر
            JobLabelIcon = "fa-solid fa-truck-pickup", -- https://fontawesome.com/
            JobImageLink = "https://example.com/police.png", -- رابط صورة البايو // 1716 على 748 هذا مقاس الصورة
            JobBioText = "يجب عليك نقل السيارات الخربانه من اجل تصليحها ولاشيئ اخر كيف حالك يا اخي هذا فقط للتست.", -- البايو او الدسكربشن حق الوظيفة
            Job = "trucker",-- اسم الوظيفة داخل اللعبه
            JobGrade = 0, -- لفل الوظيفة او الرتبة كم رقمها
            JobCoords = vector3(0, 0, 0) -- احداثيات الوظيفة بحدد عليها
        },
        [3] = {
            JobLabelText = "شركة ادارة النظافة", -- اسم الوظيفة داخل الجوب سنتر
            JobLabelIcon = "fa-solid fa-trash", -- https://fontawesome.com/
            JobImageLink = "https://example.com/doctor.png", -- رابط صورة البايو // 1716 على 748 هذا مقاس الصورة
            JobBioText = "فيتروكس هنا فلا خوف عليكم", -- البايو او الدسكربشن حق الوظيفة
            Job = "garbage", -- اسم الوظيفة داخل اللعبه
            JobGrade = 0, -- لفل الوظيفة او الرتبة كم رقمها
            JobCoords = vector3(0, 0, 0) -- احداثيات الوظيفة بحدد عليها
        }
    }
}

-- للمساعدة -- Vetrox https://discord.gg/jc3bxNTD9Y