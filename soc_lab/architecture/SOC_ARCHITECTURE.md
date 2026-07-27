# MUTEB SOC Enterprise Architecture


## Overview


MUTEB SOC simulates a Security Operations Center environment.

            Security Events

                   |

    +--------------+--------------+

    |                             |

 Linux Hosts                Windows Hosts

    |                             |

    +--------------+--------------+

                   |

            Log Collection

                   |

            SIEM Engine

                   |

          Detection Rules

      (Sigma / YARA / MITRE)

                   |

                Alerts

                   |

         SOC Analyst Dashboard

                   |

    +--------------+--------------+

    |                             |

 Incident Response          Threat Hunting

## SOC Components


### Data Sources

- Linux Logs
- Windows Events
- Authentication Events
- Network Events


### Detection Layer

- Sigma Rules
- YARA Rules
- MITRE ATT&CK Mapping


### Response Layer

- Incident Cases
- Evidence Collection
- Reports



