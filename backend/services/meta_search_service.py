import random
from duckduckgo_search import DDGS
from typing import List, Dict
from pydantic import BaseModel


class MetaSearchService:
    def __init__(self):
        self.ddgs = DDGS()

    def search_multi_source(self, query: str) -> List[Dict]:
        """
        Performs a real web search and maps results to AppModel structure
        with calculated trust scores.
        """
        results = []
        try:
            # We append 'download app' to contextually find software
            search_query = f"{query} download app"

            # Fetch raw results
            ddg_results = self.ddgs.text(search_query, max_results=10)

            for r in ddg_results:
                title = r.get("title", "Unknown")
                link = r.get("href", "")
                snippet = r.get("body", "")

                # Calculate Contextual Trust
                trust_score, badges = self._calculate_domain_trust(link)

                app_data = {
                    "id": link,  # Use URL as ID for scraping
                    "name": title.split("-")[0].split("|")[0].strip(),  # Clean title
                    "description": snippet,
                    "icon": "",  # Backend scraper would get this, mock for now or use generic
                    "human_trust_score": trust_score,
                    "source": self._determine_source_type(link),
                    "is_apk": link.endswith(".apk"),
                    "download_url": link,
                    "security_reputation": badges,
                }
                results.append(app_data)

        except Exception as e:
            print(f"Meta Search Error: {e}")
            # Fallback to empty list or cached data
            return []

        return results

    def _calculate_domain_trust(self, url: str) -> tuple[int, str]:
        """
        Returns (Score, Badge) based on domain authority.
        """
        url_lower = url.lower()

        # High Trust (Official / Reputable)
        if "play.google.com" in url_lower:
            return 98, "Official Store"
        if "github.com" in url_lower:
            return 95, "Open Source"
        if "f-droid.org" in url_lower:
            return 92, "Verified FOSS"
        if "gitlab.com" in url_lower:
            return 94, "Open Source"
        if "microsoft.com" in url_lower:
            return 96, "Official"
        if "apple.com" in url_lower:
            return 98, "Official"
        if "videolan.org" in url_lower:
            return 99, "Developer Site"
        if "mozilla.org" in url_lower:
            return 99, "Developer Site"

        # Medium Trust (Aggregators)
        if "uptodown.com" in url_lower:
            return 85, "Aggregator"
        if "apkpure.com" in url_lower:
            return 75, "Community APK"
        if "apkmirror.com" in url_lower:
            return 88, "Verified APK"
        if "softonic.com" in url_lower:
            return 60, "Aggregator (Ad-heavy)"

        # Low Trust / Unknown
        return 50, "Unknown Source"

    def _determine_source_type(self, url: str) -> str:
        if "github" in url or "gitlab" in url:
            return "GitHub"
        if "play.google" in url:
            return "Play Store"
        if "f-droid" in url:
            return "F-Droid"
        return "Web"
