
import logging
from pathlib import Path

Path("logs").mkdir(
    exist_ok=True
)

logging.basicConfig(
    filename="logs/muteb_soc.log",
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)

logger = logging.getLogger(
    "MUTEB_SOC"
)
