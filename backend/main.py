from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from typing import List, Optional
from services.meta_search_service import MetaSearchService

app = FastAPI(title="Lighthouse Master API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Real Search Service
meta_search_service = MetaSearchService()


@app.get("/")
def read_root():
    return {"status": "Lighthouse Network Online", "mode": "PROD_META_SEARCH"}


@app.get("/search", response_model=List)
def search_apps(q: str):
    """
    Real Meta-Search via DuckDuckGo + Trust Scoring
    """
    results = meta_search_service.search_multi_source(q)
    return results


@app.get("/app/{app_id}")
def get_app_details(app_id: str):
    for app in MOCK_APPS:
        if app["id"] == app_id:
            return app
    raise HTTPException(status_code=404, detail="App not found")


@app.get("/pro-stacks")
def get_pro_stacks():
    """Returns curated stacks. Client should hide this behind paywall."""
    return PRO_STACKS


@app.get("/security-scan")
def security_scan(url: str):
    """
    Simulates an on-demand security scan for an APK link.
    """
    # Mock logic: if url contains "malware", return danger
    if "malware" in url.lower():
        return {"status": "DANGER", "details": "Known malware signature detected."}
    return {
        "status": "SAFE",
        "details": "Community reports indicate this file is safe.",
    }
