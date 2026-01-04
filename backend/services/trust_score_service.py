import math
from typing import List, Dict
import sys
import os

# Add parent directory to path to allow importing mock_data
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from mock_data import MOCK_APPS

class CommunityScraperService:
    """
    Simulates scraping community forums (Reddit, Hacker News) and 
    calculating a Human Trust Score.
    """

    def search_apps(self, query: str) -> List[Dict]:
        """
        Search for apps and enrich with calculated trust scores.
        """
        # 1. Fetch raw candidates (simulated)
        candidates = self._fetch_raw_candidates(query)
        
        # 2. Calculate Trust Scores
        results = []
        for app in candidates:
            enriched_app = self._enrich_with_trust_score(app)
            results.append(enriched_app)
            
        # 3. Sort by Score
        return sorted(results, key=lambda x: x["human_trust_score"], reverse=True)

    def _fetch_raw_candidates(self, query: str) -> List[Dict]:
        """
        Simulate searching external sources.
        """
        if not query:
            return MOCK_APPS
        
        q = query.lower()
        return [
            app for app in MOCK_APPS 
            if q in app["name"].lower() or q in app["description"].lower()
        ]

    def _enrich_with_trust_score(self, app_data: Dict) -> Dict:
        """
        Advanced Trust Score Algorithm.
        Factors:
        - Sentiment (Simulated): 0.5 weight
        - Mention Frequency: 0.3 weight
        - Recent Activity: 0.2 weight
        """
        # Simulation of raw metrics
        sentiment = self._get_simulated_sentiment(app_data["id"]) # 0-100
        mentions = self._get_simulated_mentions(app_data["id"]) # Raw count
        activity = self._get_simulated_activity(app_data["id"]) # 0-100 (Freshness)

        # Normalize Mentions (Logarithmic scale, cap at 100 for 1000 mentions)
        mentions_score = min(100, (math.log(mentions + 1) / math.log(1000)) * 100)

        # Weighted Average
        final_score = (sentiment * 0.5) + (mentions_score * 0.3) + (activity * 0.2)
        
        # Merge into data
        new_data = app_data.copy()
        new_data["human_trust_score"] = int(final_score)
        new_data["metrics"] = {
            "sentiment": sentiment,
            "mentions": mentions,
            "activity": activity
        }
        return new_data

    # --- Simulated Data Providers ---

    def _get_simulated_sentiment(self, app_id: str) -> int:
        # Mocking sentiment analysis
        if app_id == "suspicious_cleaner": return 10
        if app_id == "vscode": return 95
        return 80

    def _get_simulated_mentions(self, app_id: str) -> int:
        # Mocking crawling volume
        if app_id == "vscode": return 5000
        if app_id == "obsidian": return 2000
        if app_id == "revanced": return 3000
        return 50

    def _get_simulated_activity(self, app_id: str) -> int:
        # Mocking update frequency / forum buzz
        if app_id == "revanced": return 100 # Very active
        if app_id == "newpipe": return 90
        return 60
