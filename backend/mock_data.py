from typing import List, Dict

# Mock Data simulating "Scraper Results"

MOCK_APPS = [
    {
        "id": "vscode",
        "name": "Visual Studio Code",
        "description": "Code editing. Redefined.",
        "icon": "https://upload.wikimedia.org/wikipedia/commons/9/9a/Visual_Studio_Code_1.35_icon.svg",
        "human_trust_score": 98,
        "source": "Official Store", # Official Blue
        "badges": ["Editor's Choice", "Top Rated"],
        "download_url": "https://code.visualstudio.com/",
        "is_apk": False,
        "security_reputation": "Safe"
    },
    {
        "id": "revanced",
        "name": "ReVanced Manager",
        "description": "Patcher for various Android apps.",
        "icon": "https://avatars.githubusercontent.com/u/104963385?s=200&v=4",
        "human_trust_score": 95,
        "source": "External APK", # Amber
        "badges": ["Community Vetted", "Open Source"],
        "download_url": "https://github.com/ReVanced/revanced-manager/releases/download/v1.20.0/revanced-manager-v1.20.0.apk",
        "is_apk": True,
        "security_reputation": "Safe" # Computed from community reports
    },
    {
        "id": "obsidian",
        "name": "Obsidian",
        "description": "A second brain, for you, forever.",
        "icon": "https://upload.wikimedia.org/wikipedia/commons/1/10/2023_Obsidian_logo.svg",
        "human_trust_score": 92,
        "source": "Official Store",
        "badges": ["Productivity"],
        "download_url": "https://obsidian.md/",
        "is_apk": False,
        "security_reputation": "Safe"
    },
    {
        "id": "newpipe",
        "name": "NewPipe",
        "description": "A privacy-focused YouTube client.",
        "icon": "https://newpipe.net/img/logo.svg",
        "human_trust_score": 89,
        "source": "External APK",
        "badges": ["Privacy", "FOSS"],
        "download_url": "https://newpipe.net/",
        "is_apk": True,
        "security_reputation": "Safe"
    },
    {
        "id": "suspicious_cleaner",
        "name": "Super Fast Cleaner Pro",
        "description": "Clean your phone instantly!",
        "icon": "https://via.placeholder.com/150",
        "human_trust_score": 12,
        "source": "External APK",
        "badges": ["Ad Heavy"],
        "download_url": "http://example.com/malware.apk",
        "is_apk": True,
        "security_reputation": "Risk" # Warning
    }
]

PRO_STACKS = [
    {
        "id": "dev_pack_2024",
        "title": "Ultimate Developer Stack 2024",
        "description": "The essential tools for modern web development, curated by senior architects.",
        "apps": ["vscode", "obsidian", "termux", "postman"],
        "price": "Free for Pro"
    },
    {
        "id": "privacy_guard",
        "title": "Privacy & Security Bundle",
        "description": "Go dark. Protect your data with these vetted privacy tools.",
        "apps": ["newpipe", "signal", "tor_browser"],
        "price": "Free for Pro"
    }
]
