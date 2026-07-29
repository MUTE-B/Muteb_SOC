#!/bin/bash


echo "======================================"
echo " MUTEB ENTERPRISE PRESENTATION UI"
echo "======================================"


mkdir -p frontend/src/presentation



####################################
# HERO
####################################


cat > frontend/src/presentation/Hero.jsx <<'JSX'


import React from "react";


export default function Hero(){


return (

<section>


<h1>
MUTEB SOC
</h1>


<h2>
Enterprise Cyber Command Center
</h2>


<p>
Unified Security Intelligence Platform
</p>


<h3>
SOC Operations | AI Security | Risk Intelligence
</h3>


</section>

);


}

JSX





####################################
# SECURITY OVERVIEW
####################################


cat > frontend/src/presentation/SecurityOverview.jsx <<'JSX'


import React from "react";


export default function SecurityOverview(){


return (

<div>


<h1>
Security Overview
</h1>


<div>

Security Score:

92%

</div>


<div>

Threat Level:

LOW

</div>


<div>

Compliance:

95%

</div>


<div>

Protected Assets:

120

</div>



</div>

);


}

JSX





####################################
# MODULE DISPLAY
####################################


cat > frontend/src/presentation/Modules.jsx <<'JSX'


import React from "react";


export default function Modules(){


const modules=[


"Sentinel X",

"AI Security Director",

"SOC Command Center",

"Threat Intelligence",

"Risk Engine",

"Compliance Center"


];



return (

<div>


<h1>
Enterprise Modules
</h1>


{modules.map((m)=>(

<p key={m}>

✓ {m}

</p>

))}



</div>

);


}

JSX





####################################
# ARCHITECTURE
####################################


cat > frontend/src/presentation/ArchitectureView.jsx <<'JSX'


import React from "react";


export default function ArchitectureView(){


return (

<div>


<h1>
Enterprise Architecture
</h1>


<pre>


Users

 |

Cyber Command Center

 |

Security Intelligence

 |

AI Security Director

 |

Executive Decisions


</pre>


</div>

);


}

JSX





####################################
# DOCUMENT
####################################


mkdir -p docs/presentation


cat > docs/presentation/PRESENTATION_EDITION.md <<'MD'


# MUTEB SOC Presentation Edition



Designed for:


- Enterprise Demonstration

- Portfolio Review

- Security Leadership Presentation



Includes:


- Cyber Command Center UI

- Executive View

- Module Showcase

- Architecture View



MD





echo ""

echo "======================================"

echo " MUTEB PRESENTATION EDITION READY"

echo "======================================"


